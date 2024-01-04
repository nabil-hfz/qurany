
import DataSourceProd from "./data-source-prod";
import DataSourceLocal from "./data-source-dev";
// DataSourceProd.getRepository
export default process.env.NODE_ENV === "production" ||  process.env.NODE_ENV === "prod"
  ? DataSourceProd
  : DataSourceLocal;

  // export async function initializeDb() {
//     try {
//         // to initialize the initial connection with the database, register all entities
//         // and "synchronize" database schema, call "initialize()" method of a newly created database
//         // once in your application bootstrap
//         await AppDataSource.initialize()
//             .then(() => {
//                 console.log('Successfully connected to postgres')
//             })
//             .catch(err => console.error('Error connecting to postgres', err));
//     } catch (err) {
//         console.error('Error connecting to postgres', err);
//     }
// }