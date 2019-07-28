import { Injectable } from '@angular/core';

@Injectable()
export class BusService {
    //不通模块之间传输对象
    entity: any = {}
    technicianToBeBook: any={}
    serviceToBeBook: any={}
    constructor() {}
    
}