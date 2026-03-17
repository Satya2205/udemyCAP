namespace my.cap1;
using {managed , cuid , Country} from '@sap/cds/common';

entity Employee : managed, cuid{
    firstName: String(20);
    lastName: String(20);
    email: String;
    phone: Integer;
    company: Association to Company;
    country: Country;
    // country: Association to Countrys;
}

entity Company: managed,cuid {
    key ID: Integer;
    companyName: localized String;
    countryName: String;
    companies: Association to many Employee on companies.company = $self;
}

entity Contacts : cuid, managed{
    company_ID: type of Company:ID;
    company: Association to Company on company_ID=company.ID;
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
    salesItem: Composition of many SalesItems on salesItem.items = $self;
}

entity SalesItems: managed, cuid{
    itemCategory: String;
    IS_Avaliable: Boolean;
    itemCreationDate: Date;
    items: Association to one SalesOrder;
}