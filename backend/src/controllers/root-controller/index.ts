import { AppRoutes } from "../../constant/app-routes.const";
import { Controller, HttpServer } from "../index";
import { RequestHandler } from "express";

let counter = 1;

export class RootController implements Controller {

  initialize(httpServer: HttpServer): void {
    const url = AppRoutes.rootRoute;
    // httpServer.get(url, this.root.bind(this));
    httpServer.get({ path: `${url}`, requestHandler: this.root.bind(this) });
    // httpServer.get({ path: `${url}hello-world`, requestHandler: this.root.bind(this) });
  }

  private readonly root: RequestHandler = async (req, res, next) => {
    res.send({
      status: `API is working! Counter: ${counter++}`,
    });
    // next();
  };
}
