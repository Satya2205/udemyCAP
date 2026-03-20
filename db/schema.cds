namespace my.cap1;
using {managed , cuid , Country, Currency} from '@sap/cds/common';
using { my.cap1.types } from './types';

entity Employee : managed, cuid{
    firstName: String(20);
    lastName: String(20);
    email: String;
    phone: Integer;
    company: Association to Company; // Managed Association → Default ON handled by CAP → Many-to-One(Overall Relationship) -> One-to-One(Field Relationship)
    country: Country;
    currency: Currency;
    // country: Association to Countrys;
}

aspect sap.common.CodeList{
    name: String;
    desc: String;
}

entity sap.common.Currency : sap.common.CodeList {
    key code: String(5);
}

entity Company: managed,cuid {
    key ID: Integer;
    companyName: types.companyName;
    countryName: types.countryName;
    companies: Association to many Employee on companies.company = $self; // Unmanaged Association → Explicit ON condition → One-to-Many (self reference)(Overall Relationship) -> One-to-Many(Field Relationship)
}

entity Contacts : cuid, managed{
    company_ID: type of Company:ID;
    company: Association to Company on company_ID=company.ID; // Unmanaged Association → Custom foreign key mapping → Many-to-One(Overall Relationship) -> One-to-One(Field Relationship)
}

// entity Countrys : cuid, managed{
//     parent: Association to Countrys;
//     children: Composition of many Countrys on children.parent=$self;
// }

entity SalesOrder: managed, cuid {
    salesNumber: Integer;
    customerName: localized String(20);
    customerCode: String(10);
    customerAddress: localized String(50);
    salesItem: Composition of many SalesItems on salesItem.items = $self; // Composition (Unmanaged) → Strong ownership → One-to-Many (child depends on parent)(Overall Relationship) -> One-to-Many(Field Relationship)
}

entity SalesItems: managed, cuid{
    itemCategory: String;
    IS_Avaliable: Boolean;
    itemCreationDate: Date;
    items: Association to one SalesOrder;// Managed Association → Many-to-One(Overall Relationship) -> One-to-One(Field Relationship)
}

// Many to Many using EmployeeProject Entity as junction
entity Employee3 : managed, cuid {
    firstName: String;
    assignments: Association to many EmployeeProject on assignments.employee = $self;
}

entity Project : managed, cuid {
    name: String;
    assignments: Association to many EmployeeProject on assignments.project = $self;
}

entity EmployeeProject : cuid {
    employee : Association to Employee3;
    project  : Association to Project;
}

