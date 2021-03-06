import { Entity, Column, PrimaryGeneratedColumn, JoinColumn, ManyToOne, OneToMany } from 'typeorm';
import { PersonClient } from "./personClient.entity";
import { Shipping } from "./shipping.entity";
import { PersonDestinataryStatus } from "./personDestinataryStatus.entity";

@Entity({ name: 'persona_destinatario' })
export class PersonDestinatary {
  @PrimaryGeneratedColumn({ name: 'clave' })
  id: number;

  @Column({ name: 'primer_nombre' })
  firstName: string;

  @Column({ name: 'segundo_nombre', nullable: true })
  secondName: string;

  @Column({ name: 'primer_apellido' })
  firstLastName: string;

  @Column({ name: 'segundo_apellido', nullable: true})
  secondLastName: string;

  @Column({ name: 'telefono' })
  phoneNumber: string;

  @Column({ name: 'correo' })
  email: string;

  @JoinColumn({ name: 'fk_persona_cliente' })
  @ManyToOne(type => PersonClient, personClient => personClient.personDestinataries)
  personClient: PersonClient;

  @OneToMany(type => Shipping, shippings => shippings.personDestinatary)
  shippings: Shipping[];

  @OneToMany(type => PersonDestinataryStatus, personDestinataryStatus => personDestinataryStatus.personDestinatary)
  personDestinataryStatus: PersonDestinataryStatus[];
}