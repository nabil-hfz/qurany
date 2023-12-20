import { AppError } from "./app-error";

export class AppNotFoundError extends AppError{

    constructor(){
        super();
    }
}