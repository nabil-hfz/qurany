import { DataSource } from "typeorm"
import { FileEntity } from "./entities/file-entity"
import { KhatmaEntity } from "./entities/khatma-entity"
import { RecitationEntity } from "./entities/recitation-entity"
import { ReciterEntity } from "./entities/reciter-entity"
import { isDevelopment } from "../config"
import { dbConfig } from "../config/db.config"

// const dbConfig = require("../config/db.config.js");


export const AppDataSource = new DataSource({
    type: "postgres",
    host: dbConfig.HOST,
    port: 5432,
    username: dbConfig.USER,
    password:  dbConfig.PASSWORD,
    database: dbConfig.DB,
    entities: [FileEntity, KhatmaEntity, RecitationEntity, ReciterEntity],
    synchronize: true,
    logging: isDevelopment,
})


export async function initializeDb() {
    try {
        // to initialize the initial connection with the database, register all entities
        // and "synchronize" database schema, call "initialize()" method of a newly created database
        // once in your application bootstrap
        await AppDataSource.initialize()
            .then(() => {
                console.log('Successfully connected to postgres')
            })
            .catch(err => console.error('Error connecting to postgres', err));
    } catch (err) {
        console.error('Error connecting to postgres', err);
    }
}