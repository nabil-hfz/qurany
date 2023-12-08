import initConfig from "./config/index";
initConfig();

import { Express } from "express";
import * as express from "express";
import { interceptors } from "./interceptors";
import { HttpServer } from "./controllers";
import { CONTROLLERS } from "./controllers/controllers";
import * as cors from "cors";
import { log } from "./utils/logger";
import * as bodyParser from "body-parser";
import * as timeout from "connect-timeout";


// import * as http from "http";
// import * as https from "https";


const app: Express = express();
app.use(timeout(1000 * 60 * 3))

// Automatically allow cross-origin requests
app.use(cors({ origin: true }));
// app.use(bodyParser.text({ limit: '1024mb' }))
// app.use(bodyParser.raw({ limit: '1024mb' }))
const maxFileSize = 1024 * 1024 * 1024 * 5 ;
app.use(bodyParser.json({ limit: maxFileSize }))
app.use(bodyParser.urlencoded({ limit: maxFileSize, extended: true, parameterLimit:maxFileSize }))

interceptors.forEach((interceptor) => {
  app.use(interceptor);
})
const httpServer = new HttpServer(app);
CONTROLLERS.forEach((controller) => {
  controller.initialize(httpServer);
});

app.get('/', (req, res) => {
  res.status(200).send('Hellow world!');
});
app.get('/health', (req, res) => {
  res.status(200).send('Health: OK');
});

// Listen to the App Engine-specified port, or 8080 otherwise
const PORT = process.env.PORT;
app.listen(PORT, () => {
  log(`Server listening on port http://localhost:${PORT}...`);
});
// https://www.youtube.com/watch?v=CqY2kYJQoK0







// http.createServer(app).listen(port, () => {
//   console.log("Hello nabil");
//   log(`⚡️[server]: Server is running at http://localhost:${port}`);
// });

// https.createServer(app).listen(port, () => {
//   console.log("Hello nabil");
//   log(`⚡️[server]: Server is running at https://localhost:${port}`);
// });
// app.listen(port, () => {
//   console.log("Hello nabil");
//   log(`⚡️[server]: Server is running at http://localhost:${port}`);
// });


// export const api = firebaseDep.handleRequests(app);

// exports.widgets = api;
// module.exports = {api};

// https://eu-central-1.console.aws.amazon.com/ecr/repositories/private/021171570288/qurany-api-dev?region=eu-central-1
// Medium article : https://betterprogramming.pub/deploying-node-js-app-on-aws-cloud-in-a-serverless-way-d889a9444ef7

// docker build -t qurany-api-dev .
// docker run -it -p 7777:7777 qurany-api-dev
// docker run -d -p 7777:7777 qurany-api-dev
// docker image ls
// docker rmi $(docker images -q)
// docker ps
// docker ps -a
// Stop all running containers :  docker stop $(docker ps -a -q)
// Delete all stopped containers: docker rm $(docker ps -a -q)


// AMAZON : eb init --platform node.js --region eu-central-1
// AMAZON : eb create --sample qurany-dev-eb


//1- aws ecr create-repository --repository-name qurany-dev-repository --region eu-central-1
//2- aws ecr delete-repository --repository-name qurany-dev-repository --region eu-central-1 --force
//3- docker login -u AWS -p $(aws ecr get-login-password --region eu-central-1) 021171570288.dkr.ecr.eu-central-1.amazonaws.com
//4- docker push 021171570288.dkr.ecr.eu-central-1.amazonaws.com/qurany-dev-repository
//5- aws ecr delete-repository --repository-name qurany-dev-repository --region eu-central-1 --force




//1- aws ecr create-repository --repository-name hello-repository --region eu-central-1
//2- aws ecr delete-repository --repository-name hello-repository --region eu-central-1 --force
//3- docker login -u AWS -p $(aws ecr get-login-password --region eu-central-1) 021171570288.dkr.ecr.eu-central-1.amazonaws.com
//4- docker push 021171570288.dkr.ecr.eu-central-1.amazonaws.com/hello-repository
//5- aws ecr delete-repository --repository-name hello-repository --region eu-central-1 --force


 


// https://www.youtube.com/watch?v=2Ti6r34odOw
// https://www.youtube.com/watch?v=0YTs40kvnW0&list=PLjl2dJMjkDjkBIKd_S9YeBMsT92L8KD4m&index=11
// https://www.youtube.com/watch?v=S45jZCvd2M8&t=43s