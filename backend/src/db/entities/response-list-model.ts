export class ResponseListModel {


    constructor(private data: ResponseListProto) { 
        this.data;
    }

    static toResult(data: ResponseListProto) {
        
        return data;
    }
}


interface ResponseListProto {
    items: any[];
    message?: string;
}