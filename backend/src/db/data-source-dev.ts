import { DataSource, DataSourceOptions } from "typeorm"
import { isDevelopment } from "../config"
import { SnakeNamingStrategy } from 'typeorm-naming-strategies'

const POSTGRESQL_DB_HOST = process.env.POSTGRESQL_DB_HOST;
const POSTGRESQL_DB_USER = process.env.POSTGRESQL_DB_USER;
const POSTGRESQL_DB_PASSWORD = process.env.POSTGRESQL_DB_PASSWORD;
const POSTGRESQL_DB = process.env.POSTGRESQL_DB;


let connectionOptions: DataSourceOptions = {
    type: "postgres",
    host: POSTGRESQL_DB_HOST,
    port: 5432,
    username: POSTGRESQL_DB_USER,
    password: POSTGRESQL_DB_PASSWORD,
    database: POSTGRESQL_DB,
    namingStrategy: new SnakeNamingStrategy(),
    entities: [
        __dirname + "/entities/*.ts",
    ],
    migrations: [
        __dirname + "/migrations/*.ts",
    ],
    synchronize: false,
    logging: isDevelopment,
};


export default new DataSource(connectionOptions);


// export async function initializeDb() {
//     try {
//         // to initialize the initial connection with the database, register all entities
//         // and "synchronize" database schema, call "initialize()" method of a newly created database
//         // once in your application bootstrap
//         await dataSource.initialize()
//             .then(() => {
//                 console.log('Successfully connected to postgres')
//             })
//             .catch(err => console.error('Error connecting to postgres', err));
//     } catch (err) {
//         console.error('Error connecting to postgres', err);
//     }
// }