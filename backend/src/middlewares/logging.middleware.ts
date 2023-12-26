import { Request, Response, NextFunction } from 'express';

export function logRequests(req: Request, res: Response, next: NextFunction): void {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
}
