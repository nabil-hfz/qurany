
import DataSourceProd from "./data-source-prod";
import DataSourceDev from "./data-source-dev";
// DataSourceProd.getRepository
const isProduction = process.env.NODE_ENV === "production" || process.env.NODE_ENV === "prod";
export default isProduction
  ? DataSourceProd
  : DataSourceDev;