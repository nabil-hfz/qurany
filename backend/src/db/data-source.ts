
import DataSourceProd from "./data-source-prod";
import DataSourceDev from "./data-source-dev";
// DataSourceProd.getRepository
export default process.env.NODE_ENV === "production" ||  process.env.NODE_ENV === "prod"
  ? DataSourceProd
  : DataSourceDev;