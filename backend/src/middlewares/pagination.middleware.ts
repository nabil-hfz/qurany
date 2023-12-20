import { Request, Response, NextFunction } from 'express';

export async function paginationMiddleware(req: Request, res: Response, next: NextFunction) {
  const defaultPage = 1;
  const defaultLimit = 10;

  let page = parseInt(req.query.page as string);
  let limit = parseInt(req.query.limit as string);

  if (isNaN(page) || page < 1) {
    page = defaultPage;
  }

  if (isNaN(limit) || limit < 1) {
    limit = defaultLimit;
  }

  // Attaching parsed values to the request
  req.pagination = {
    page,
    limit,
  };

  next();
}

// Extend the Express Request interface to include pagination
declare global {
  namespace Express {
    interface Request {
      pagination?: AppPagination;
    }
  }
}

export interface AppPagination {
  page: number;
  limit: number;
}