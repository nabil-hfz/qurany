import * as path from "path";
import * as dotenv from "dotenv";

export const currentEnv = process.env.NODE_ENV as string;


export default function init() {
  const projectName = currentEnv;
  let envPath;
  switch (projectName) {
    case "dev":
      envPath = path.resolve(process.cwd(), "./src/environment/.env.dev");
      break;
    case "prod":
      envPath = path.resolve(process.cwd(), "./src/environment/.env.prod");
      break;
    default:
      throw new Error("Application not supported");
  }
  dotenv.config({ path: envPath, debug: true, override: true });
  console.log(`process env ${currentEnv}`);
}

