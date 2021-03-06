import { Injectable, Inject, UnauthorizedException, InternalServerErrorException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, UpdateResult, getManager } from 'typeorm';
import { User } from '../../entities/user.entity';
import { PersonClient } from "../../entities/personClient.entity";
import { Role } from "../../entities/role.entity";
import { Status } from "../../entities/status.entity";
import { UserStatus } from "../../entities/userStatus.entity";
import { PersonDestinatary } from "../../entities/personDestinatary.entity";
import { Logger } from 'winston';
import { CreateInfo } from "../../dto/createInfo.dto";
import { SchedulerRegistry } from '@nestjs/schedule';
import { CronJob } from 'cron';
import { Shipping } from 'src/entities/shipping.entity';
import { ShippingStatus } from "../../entities/shippingStatus.entity";
import { Road } from "../../entities/road.entity";

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(User)
    private userRepository: Repository<User>,
    @InjectRepository(PersonClient)
    private personClientRepository: Repository<PersonClient>,
    @InjectRepository(Role)
    private roleRepository: Repository<Role>,
    @InjectRepository(Status)
    private statusRepository: Repository<Status>,
    @InjectRepository(PersonDestinatary)
    private personDestinataryRepository: Repository<PersonDestinatary>,
    @Inject('winston')
    private readonly logger: Logger,
    private scheduler: SchedulerRegistry
  ){}

  addCronJob(name: string, seconds: string) {
    let number = [1,2,3,4,5,6,7,8,9];
  const job = new CronJob(`${seconds} * * * * *`, () => {
    this.logger.warn(`time (${seconds}) for job ${name} to run!`);
  });

  this.scheduler.addCronJob(name, job);
  job.start();

  this.logger.warn(
    `job ${name} added for each minute at ${seconds} seconds!`,
  );
}
  async getRoleByName(roleName: string): Promise<Role> {
    const role : Role = await this.roleRepository.findOne({
      where: { name: roleName }
    });
    return role;
  }

  async getStatusByName(statusName: string): Promise<Status> {
    const status : Status = await this.statusRepository.findOne({
      where: { name: statusName }
    });
    return status;
  }

  /**
   * Obtiene el usuario junto a su personaCliente y su rol que posea el nombre de usuario y el rol pasado por parametros
   *
   * @param   {string}           name      nombre del usuario a conseguir
   * @param   {string}           rolename  nombre del rol que debe poseer el usuario
   *
   * @return  {Promise<User>}              Usuario que se quiere obtener
   */
  async getUserByUsername (name: string): Promise<User>{
    const user : User = await this.userRepository.findOne({
      where: { username: name },
      relations:['personClient','role']
    });
    return user;
  }

  async getUserByEmail (email: string): Promise<User>{
    const person : PersonClient = await this.personClientRepository.findOne({
      where: { email: email }
    });
    const user : User = await this.userRepository.findOne({
      where: { personClient: person },
      relations:['personClient','role']
    });
    return user;
  }

  async thisEmailIsInUse(sendEmail: string): Promise<boolean>{
    const personClient : PersonClient = await this.personClientRepository.findOne({
      where: { email: sendEmail }
    });
    if(personClient)
      return true;
    else
      return false;
  }

  async thisUsernameIsInUse(sendUsername: string): Promise<boolean>{
    const user : User = await this.userRepository.findOne({
      where: { username: sendUsername }
    });
    if(user)
      return true;
    else
      return false;
  }

  async createPersonUser(user: Partial<User>, personID, roleName: string, transactionalEntityManager): Promise<number>{
    const userTransactionRepository: Repository<User> = transactionalEntityManager.getRepository(
      User,
    );
    user.personClient = personID;
    user.role = await this.getRoleByName(roleName);
    const newUser = await userTransactionRepository.save(user);
    return newUser.id;
  }

  async deletePersonClient(emailDelete: string): Promise<void>{
    this.personClientRepository.delete({ email: emailDelete });
  }

  async createStatusUser(userStatus: Partial<UserStatus>,newUserID: number, statusName: string, transactionalEntityManager): Promise<void>{
    const userStatusTransactionRepository: Repository<UserStatus> = transactionalEntityManager.getRepository(
      UserStatus,
    );
    const userTransactionRepository: Repository<User> = transactionalEntityManager.getRepository(
      User,
    );
    userStatus.user = await userTransactionRepository.findOne(newUserID);
    userStatus.status = await this.getStatusByName(statusName);
    userStatus.date = new Date().toJSON();
    await userStatusTransactionRepository.save(userStatus);
  }
  
  /**
   * Metodo que crea a la PersonaCliente y al Usuario, además de asignarle al Usuario sus respectivas relaciones con Rol y Estatus
   * @param   {CreateInfo}           info      información del usuario que se intenta crear
   *
   */
  async createUser(info: CreateInfo): Promise<void> {
    this.logger.info(`[UserService] Validating the information to create the user [${info.user.username}]`);
    if(!(await this.thisEmailIsInUse(info.email))){
      if(!(await this.thisUsernameIsInUse(info.user.username))){
        this.logger.info(`[UserService] Creating the user [${info.user.username}]`);
        return await getManager().transaction(async transactionalEntityManager => {
                try{
                  const newPerson = {
                    firstName: info.firstName,
                    secondName: info.secondName,
                    firstLastName: info.firstLastName,
                    secondLastName: info.secondLastName,
                    phoneNumber: info.phoneNumber,
                    email: info.email,
                    birthDate: info.birthDate,
                    identNum: info.identNum,
                    photo: "None"
                  };
                  const insertedPerson : PersonClient = await this.personClientRepository.save(newPerson);
                  const newUserID = await this.createPersonUser(info.user,insertedPerson.id,'User',transactionalEntityManager);
                  await this.createStatusUser({},newUserID,'Active',transactionalEntityManager);
                }
                catch(ex){
                  this.logger.error(`[UserService] Could not create user [${info.user.username} | ${info.email}], an unexpected error occurred | Exception: ex=${ex}`);
                  if(this.thisEmailIsInUse(info.email))
                    this.deletePersonClient(info.email);
                  throw new InternalServerErrorException(`Error Interno en la creación de la persona`);
                }
        })
      }
      else{
        this.logger.error(`[UserService] Cannot create user, username [${info.user.username}] already used`);
        throw new UnauthorizedException("The username is already in use in Delivrier");
      }
    }
    else{
      this.logger.error(`[UserService] Cannot create user, mail to create user [${info.user}] alredy used`);
      throw new UnauthorizedException("The email is already in use in Delivrier");
    }
  }

  async getPersonDestinatary(clientId: number): Promise<PersonDestinatary[]>{
    this.logger.info(`[UserService] getPersonDestinatary: [user.id | ${clientId}]`);
    const contacts: PersonDestinatary[] = await this.personDestinataryRepository.find({
      where:` personClient.id = ${clientId}`,
      join:{
        alias: 'personDestinatary',
        innerJoin:{
          personClient: 'personDestinatary.personClient'
        }
      }
    });
    return contacts;
  }

  findStatus(name: string, status): boolean {
    let result = false;
    status.forEach(stat => {
      if (stat.status.name === name){
        result = true;
      }
    });
    return result
  }

  getActualStatus(status): string {
    if (this.findStatus("Delivered",status))
      return "Delivered"
    else if (this.findStatus("In Transit",status))
      return "In Transit"
    else if (this.findStatus("Out for Delivery",status))
      return "Out for Delivery"
    else
      return "Active"
  }

  getEndingPlace(roads: Road[]){
    let final;
    roads.forEach(road => {
      final = road.endingPlace
    });
    return final
  }

  getinitialOffice(roads: Road[]){
    let office;
    roads.forEach(road => {
      if (road.initialOffice)
        office = road.initialOffice
    });
    return office;
  }

  async getUserShippings(userId: number) {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['shippings','shippings.roads','shippings.roads.initialPlace','shippings.roads.initialOffice','shippings.roads.initialOffice.place','shippings.roads.endingPlace','shippings.personDestinatary','shippings.shippingStatus','shippings.shippingStatus.status']
    });
    if(user.shippings.length){
      let shippments = [];
      user.shippings.forEach(ship => {
        shippments.push({
          id : ship.id,
          numberTrack : ship.nLocalitation,
          initialDate : ship.shippingStatus[0].date,
          status : this.getActualStatus(ship.shippingStatus),
          personDestinatary : ship.personDestinatary,
          initialOffice : this.getinitialOffice(ship.roads),
          endingPlace : this.getEndingPlace(ship.roads)
        })
      });
      return shippments;
    }
    else{
      return "Este usuario no ha realizado ningún envío"
    }
  }
}
