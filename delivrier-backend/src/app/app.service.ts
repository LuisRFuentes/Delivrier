import { Injectable, Inject } from '@nestjs/common';
import { Logger } from 'winston';

@Injectable()
export class AppService {

  constructor(
    @Inject('winston')
    private readonly logger: Logger,
  ) { }

}
