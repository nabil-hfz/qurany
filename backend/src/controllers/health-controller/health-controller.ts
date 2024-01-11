import { RequestHandler } from 'express';
import { Controller, HttpServer } from "../index";
import { AppRoutes } from '../../constant/app-routes.const';


export class HealthController implements Controller {

  url = AppRoutes.healthRoute;

  initialize(httpServer: HttpServer): void {
    httpServer.get({
      path: this.url,
      requestHandler: this.getFileEntryList.bind(this),
      customClaims: ['user'],
    });
  }

  private readonly getFileEntryList: RequestHandler = async (req, res, next) => {
    res.status(200).send('Health: OK');
  };

}


