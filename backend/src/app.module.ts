import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
@Module({imports:[ConfigModule.forRoot({isGlobal:true}),TypeOrmModule.forRoot({type:'postgres',host:process.env.DB_HOST || 'localhost',port:Number(process.env.DB_PORT || 5432),username:process.env.DB_USERNAME || 'postgres',password:process.env.DB_PASSWORD || 'engremiat',database:process.env.DB_DATABASE || 'engremiat',autoLoadEntities:true,synchronize:false})],controllers:[AppController]}) export class AppModule {}
