import { DataSource, DataSourceOptions } from "typeorm"
import { isDevelopment } from "../config"
import { SnakeNamingStrategy } from 'typeorm-naming-strategies'


const POSTGRESQL_DB_HOST = process.env.POSTGRESQL_DB_HOST;
const POSTGRESQL_DB_USER = process.env.POSTGRESQL_DB_USER;
const POSTGRESQL_DB_PASSWORD = process.env.POSTGRESQL_DB_PASSWORD;
const POSTGRESQL_DB = process.env.POSTGRESQL_DB;


// console.log('dbConfig.HOST ', POSTGRESQL_DB_HOST);
// console.log('dbConfig.USER ', POSTGRESQL_DB_USER);
// console.log('dbConfig.PASSWORD ', POSTGRESQL_DB_PASSWORD);
// console.log('dbConfig.DB ', POSTGRESQL_DB);

let connectionOptions: DataSourceOptions = {
    type: "postgres",
    host: POSTGRESQL_DB_HOST,
    port: 5432,
    username: POSTGRESQL_DB_USER,
    password: POSTGRESQL_DB_PASSWORD,
    database: POSTGRESQL_DB,
    namingStrategy: new SnakeNamingStrategy(),
    entities: [
        __dirname + "/../dist/entities/*.js",
    ],
    migrations: [
        __dirname + "/../dist/migrations/*.js",
    ],
    // entities: [
    //     __dirname + "/../../entities/*.js",
    // ],
    // migrations: [
    //     __dirname + "/../../migrations/*.js",
    //     // __dirname + '/../**/*.entity.{js,ts}'
    // ],
    synchronize: false,
    logging: isDevelopment,

};


export default new DataSource(connectionOptions);
