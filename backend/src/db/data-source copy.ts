
import { DataSource, DataSourceOptions } from "typeorm"
import { isDevelopment } from "../config"
import { SnakeNamingStrategy } from 'typeorm-naming-strategies'

import * as fs from 'fs';
import * as path from 'path';


const entitiesDir = path.join(__dirname, "/entities");
const migrationsDir = path.join(__dirname, "/migrations");

console.log('entitiesDir directory: ', entitiesDir);
console.log('migrationsDir directory: ', migrationsDir);


function extractFiles(folderPath: string): string[] {
  let files: string[] = [];
  // Read all files in the directory
  let migrationFiles = fs.readdirSync(folderPath);
  // Filter out only .js files
  files = migrationFiles.filter(file => path.extname(file) === '.js');
  // Log each .js file
  console.log('JavaScript files in the directory: ', files.length);
  files.forEach(file => {
    console.log(file);
  });

  return files;
}

let entities: string[] = extractFiles(entitiesDir);
let migrations: string[] = extractFiles(migrationsDir);



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
  entities: entities,
  migrations: migrations,
  synchronize: false,
  logging: isDevelopment,
};

// const isProduction = process.env.NODE_ENV === "production" || process.env.NODE_ENV === "prod";

export default new DataSource(connectionOptions);

// export default isProduction
//   ? DataSourceProd
//   : DataSourceDev;