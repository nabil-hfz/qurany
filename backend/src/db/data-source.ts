import { DataSource, DataSourceOptions } from "typeorm";
import { isDevelopment } from "../config";
import { SnakeNamingStrategy } from "typeorm-naming-strategies";

import * as fs from "fs";
import * as path from "path";

// Paths to entities and migrations
const entitiesDir = path.join(__dirname, "/entities");
const migrationsDir = path.join(__dirname, "/migrations");

console.log("entitiesDir directory: ", entitiesDir);
console.log("migrationsDir directory: ", migrationsDir);

// Function to dynamically import JS files and return class references
// function extractEntities(folderPath: string): any[] {
//   const files = fs.readdirSync(folderPath).filter((file) => path.extname(file) === ".js");
//   const classes = files.map((file) => {
//     const entity = require(path.join(folderPath, file));
//     console.log("Entity: ", entity);
//     return entity.default || entity; // Handles both named and default exports
//   });
//   return classes;
// }

// function extractEntities({ folderPath }: { folderPath: string; }): any[] {
//   const files = fs.readdirSync(folderPath).filter((file) => path.extname(file) === ".js");
//   const classes = files.map((file) => {
//     const entity = require(path.join(folderPath, file));
//     const entityClass = entity.default || entity; // Handles both default and named exports

//     // Check if the entityClass is valid and has the expected structure
//     if (typeof entityClass === 'function' && entityClass.name) {
//       console.log(`Loaded entity: ${entityClass.name}`);
//       return entityClass;
//     } else {
//       console.warn(`Warning: Skipped invalid entity export in file ${file}`);
//       return file;
//     }
//   });

//   // Filter out any null or invalid entries
//   return classes.filter((cls) => cls !== null);
// }


function extractEntities(folderPath: string): any[] {
  const files = fs.readdirSync(folderPath).filter((file) => path.extname(file) === ".js");

  const classes = files.map((file) => {
    const entity = require(path.join(folderPath, file));

    // Check for default export first
    if (entity.default) {
      return entity.default;
    }

    // Check if the entity has named exports (like ReciterEntity)
    const keys = Object.keys(entity);
    if (keys.length > 0) {
      console.log(`Loaded named entity: ${keys[0]}`);
      return entity[keys[0]]; // Assuming the first key is the entity class
    }

    // If no valid export is found, warn and skip
    console.warn(`Warning: Skipped invalid entity export in file ${file}`);
    return null;
  });

  // Filter out any null or invalid entries
  return classes.filter((cls) => cls !== null);
}


// function extractFilePaths(folderPath: string): string[] {
//   return fs.readdirSync(folderPath)
//     .filter((file) => path.extname(file) === ".js")  // Assuming you're running in production and using JS files
//     .map((file) => path.join(folderPath, file));
// }


// Function to extract migration file paths
function extractMigrations(folderPath: string): string[] {
  return fs.readdirSync(folderPath)
    .filter((file) => path.extname(file) === ".js")
    .map((file) => path.join(folderPath, file));
}

const entities = extractEntities(entitiesDir);
const migrations = extractMigrations(migrationsDir);

console.log('Loaded Entities:', entities);
console.log('Loaded Migrations:', migrations);
console.log('Loaded entities:', [path.join(__dirname, 'entities/*.js')]);

const POSTGRESQL_DB_HOST = process.env.POSTGRESQL_DB_HOST;
const POSTGRESQL_DB_USER = process.env.POSTGRESQL_DB_USER;
const POSTGRESQL_DB_PASSWORD = process.env.POSTGRESQL_DB_PASSWORD;
const POSTGRESQL_DB = process.env.POSTGRESQL_DB;

const connectionOptions: DataSourceOptions = {
  type: "postgres",
  host: POSTGRESQL_DB_HOST,
  port: 5432,
  username: POSTGRESQL_DB_USER,
  password: POSTGRESQL_DB_PASSWORD,
  database: POSTGRESQL_DB,
  namingStrategy: new SnakeNamingStrategy(),
  entities: [path.join(__dirname, 'entities/*.js')],  // Load entities by path
  migrations: [path.join(__dirname, 'migrations/*.js')],  // Load migrations by path
  // entities: entities, // Entity class references
  // migrations: migrations, // Migration file paths
  synchronize: false,
  logging: isDevelopment,
};

export default new DataSource(connectionOptions);
