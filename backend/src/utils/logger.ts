// import { ErrorReporting } from "@google-cloud/error-reporting";
import { firebaseDep } from "../firebase/firebase-datasource";
// import { Logger } from "winston";
// import * as winston from "winston";

// import * as path from "path";

/**
 * Also all logs levels are written in the same file,
 * You can change this behavior as you prefer
 *
 * DO NOT put your logs inside the project folder.
 *
 * */
// Instantiates a client
// const errors = new ErrorReporting({ reportMode: 'always' });
// const express = require('express');

// // Imports the Google Cloud client library
// const {ErrorReporting} = require('@google-cloud/error-reporting');

// // Instantiates a client
// const errors = new ErrorReporting();

// const app = express();

// app.get('/error', (req, res, next) => {
//   res.send('Something broke!');
//   next(new Error('Custom error message'));
// });

// app.get('/exception', () => {
//   JSON.parse('{"malformedJson": true');
// });

// // Note that express error handling middleware should be attached after all
// // the other routes and use() calls. See the Express.js docs.
// app.use(errors.express);

// const PORT = process.env.PORT || 7777;
// app.listen(PORT, () => {
//   console.log(`App listening on port ${PORT}`);
//   console.log('Press Ctrl+C to quit.');
// });
// Use the error message builder to customize all fields ...
// const errorEvent = errors.event();

// // Add error information
// errorEvent.setMessage('My error message');
// errorEvent.setUser('root@nexus');

// // Report the error event
// errors.report(errorEvent, () => {
//   console.log('Done reporting error event!');
// });

// // Report an Error object
// errors.report(new Error('My error message'), () => {
//   console.log('Done reporting Error object!');
// });

// // Report an error by provided just a string
// errors.report('My error message', () => {
//   console.log('Done reporting error string!');
// });



// function projectName() {
//   try {
//     const projectPath = require.main?.filename;
//     if (!projectPath?.length) {
//       return "";
//     }
//     const path = projectPath.split("/");
//     let projectFolderName = "";
//     for (let i = path.length - 1; i >= 0; i--) {
//       if (path[i] == "src") {
//         projectFolderName = path[i - 1];
//         break;
//       }
//     }
//     return projectFolderName;
//   } catch (e: any) {
//     logError(e.toString());
//     return "";
//   }
// }

// let loggerDay = -1;
// let _logger: Logger;
// export function logger() {
//   const currentDay = new Date().getDate();
//   if (loggerDay != currentDay) {
//     loggerDay = currentDay;
//     _logger?.close();

//     const logsFilename = `${new Date().getFullYear()}-${
//       new Date().getMonth() + 1
//     }-${new Date().getDate()}.log`; // filename example: "2022-10-8.log"

//     const logsPathAndFilename = path.join(__dirname, "../../logs", projectName(), logsFilename);


//     _logger = winston.createLogger({
//       transports: [
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "silly" as Level,
//         }),
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "debug" as Level,
//         }),
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "verbose" as Level,
//         }),
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "http" as Level,
//         }),
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "info" as Level,
//         }),
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "warn" as Level,
//         }),
//         new winston.transports.File({
//           filename: logsPathAndFilename,
//           level: "error" as Level,
//         }),
//       ],
//     });
//   }
//   return _logger;
// }

export type Level =
  | "error"
  | "warn"
  | "info"
  | "http"
  | "verbose"
  | "debug"
  | "silly";

export function log(message: any, level: Level = "debug") {

  if (level === "error") {
    console.error(`level is ${level}, message: `, message);
  } else {
    console.log(`level is ${level}, message: `, message);
  }
}

export function logDebug(message: any): void {
  const msg = `${JSON.stringify(message)} debug`;
  log(msg, "debug");
  firebaseDep.appLogger().debug(msg);

}

export function logStartRequest(req: any, controllerName  = '', functionName  = ''): void {
  const routePath = '(' + JSON.stringify(req?.route.path) + ')';
  const routeHeaders = '(' + JSON.stringify(req?.headers) + ')';
  const routeQuery = '(' + JSON.stringify(req?.query) + ')';
  const paramQuery = '(' + JSON.stringify(req?.params) + ')';
  const msg = `Started Router is: ${routePath}. ${controllerName} is triggering func ${functionName} request(${req})`;
  log(msg, "info");

  firebaseDep.appLogger().info(`Started Router is: ${routePath}. ${controllerName} is triggering func ${functionName}`);
  firebaseDep.appLogger().info(`Request headers are : ${routeHeaders}`);
  firebaseDep.appLogger().info(`Request query parameters are : ${routeQuery}`);
  // firebaseDep.appLogger().info(`Request body is : ${req?.body}`); // Horoable print
  firebaseDep.appLogger().info(`Request params are : ${paramQuery}`);
}

export function logEndSuccessRequest(req: any, controllerName = '', functionName = ''): void {
  const msg = `Started End is : [${req?.route}]. ${controllerName} is triggering func ${functionName}`;
  log(msg, "info");
  firebaseDep.appLogger().info(msg);

}
export function logInfo(message: any): void {
  const msg = `${(message)} info`;

  log(msg, "info");
  firebaseDep.appLogger().info(msg);
}

export function logWarn(message: any): void {
  const msg = `${JSON.stringify(message)} warn`;

  log(msg, "warn");
  firebaseDep.appLogger().warn(msg);
}

export function logError(message: any): void {
  const msg = `${JSON.stringify(message)} error`;

  log(msg, "error");
  firebaseDep.appLogger().error(msg);
  // if (process.env.NODE_ENV === 'prod')
  //   errors.report(`Something broke! ${JSON.stringify(message)}`);

}
