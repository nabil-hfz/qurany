export class ResponseModel {


    constructor(data: ResponseListProto) {

    }

    static toResult(data: any){
        return data;
    }
}


interface ResponseListProto {
    item: any;
    message?: string;
}