namespace my.cap1;
using {managed , cuid , sap} from '@sap/cds/common';

entity Employee : managed, cuid{
    firstName: String(20);
    lastName: String(20);
    email: String;
    phone: Integer;
}