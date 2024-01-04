import { DataSource, DataSourceOptions } from "typeorm"
import { isDevelopment } from "../config"
import { SnakeNamingStrategy } from 'typeorm-naming-strategies'

let connectionOptions: DataSourceOptions = {
    type: "postgres",
    host: "localhost",
    port: 5432,
    username: "kawtharuna_user",
    password: "DEV_PASSWORD_THANK_YOU",
    database: "kawtharuna",
    synchronize: false,
    logging: isDevelopment,
    namingStrategy: new SnakeNamingStrategy(),
    entities: [
        __dirname + "/entities/*.ts",
    ],
    migrations: [
        __dirname + "/migrations/*.ts",
    ]
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