import { Controller, Get } from '@nestjs/common';
import { DataSource } from 'typeorm';
@Controller() export class AppController{constructor(private readonly ds:DataSource){} @Get('health') health(){return {ok:true,service:'engremiat-backend-new'};} @Get('db/health') async db(){const r=await this.ds.query('SELECT current_database() as database, version() as version'); return {ok:true,...r[0]};}}
