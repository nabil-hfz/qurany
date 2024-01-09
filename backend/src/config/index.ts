import * as path from "path";
import * as dotenv from "dotenv";

export let currentEnv = process.env.NODE_ENV;

// export NODE_ENV=dev
// export NODE_ENV=prod
function init() {
  const projectName = currentEnv;
  let envPath;
  switch (projectName) {
    case "prod":
      currentEnv = "prod";
      envPath = path.resolve(process.cwd(), "./src/environment/.env.prod");
      break;
    case "dev":
    default:
      envPath = path.resolve(process.cwd(), "./src/environment/.env.dev");
      currentEnv = "dev";
      break;
  }
  dotenv.config({ path: envPath, debug: true, override: true });
  console.log(`process env ${currentEnv}`);
}
init();
export const isDevelopment = currentEnv == "dev";
