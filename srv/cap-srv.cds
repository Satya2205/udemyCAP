using {my.cap1 as myCapSrv} from '../db/schema';

service EmployeeSrv{
    entity Employee as projection on myCapSrv.Employee;
}