
import "reflect-metadata";
import * as path from "path";


import dataSource from "./db/data-source"

import { options } from "./swagger/swagger.config";


import { Express } from "express";
import * as express from "express";
import { interceptors } from "./interceptors";
import { HttpServer } from "./controllers";
import { CONTROLLERS } from "./controllers/controllers";
import * as cors from "cors";
import { log } from "./utils/logger";
import * as bodyParser from "body-parser";
import * as timeout from "connect-timeout";

import * as swaggerJsdoc from 'swagger-jsdoc';
import * as swaggerUi from 'swagger-ui-express';
import { logRequests } from "./middlewares/logging.middleware";



dataSource.initialize()
  .then(() => {
    console.log('Successfully connected to postgres')
  })
  .catch(err => console.error('Error connecting to postgres', err));

const swaggerSpec = swaggerJsdoc(options);

const app: Express = express();
app.use(logRequests);

app.use(timeout(1000 * 60 * 3))

// Automatically allow cross-origin requests
app.use(cors({ origin: true }));

const maxFileSize = 1024 * 1024 * 1024 * 5;
app.use(bodyParser.json({ limit: maxFileSize }))

app.use(bodyParser.urlencoded({ limit: maxFileSize, extended: true, parameterLimit: maxFileSize }))

interceptors.forEach((interceptor) => {
  app.use(interceptor);
})

const httpServer = new HttpServer(app);
CONTROLLERS.forEach((controller) => {
  controller.initialize(httpServer);
});


// Services the application code documentation
const index = __dirname.lastIndexOf('/');
const docsDirPath = __dirname.substring(0, index);
app.use('/code-docs', express.static(path.join(docsDirPath, 'docs')));

// Services the application API documentation
app.use('/', swaggerUi.serve, swaggerUi.setup(swaggerSpec));


const PORT = process.env.PORT || 8080;
app.listen(PORT, () => {
  log(`Server listening on port http://localhost:${PORT}...`);
});

// https://www.youtube.com/watch?v=CqY2kYJQoK0
// https://www.youtube.com/watch?v=2Ti6r34odOw
// https://www.youtube.com/watch?v=0YTs40kvnW0&list=PLjl2dJMjkDjkBIKd_S9YeBMsT92L8KD4m&index=11
// https://www.youtube.com/watch?v=S45jZCvd2M8&t=43s

