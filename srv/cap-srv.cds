using {my.cap1 as myCapSrv} from '../db/schema';

service EmployeeSrv{
    entity Employee as projection on myCapSrv.Employee;
    annotate Employee with @odata.draft.enabled;

    entity Employee1 as select from myCapSrv.Employee{*, company.companyName} excluding {createdAt, createdBy}
}

service CompanyService{
    entity Company as projection on myCapSrv.Company;
    entity Contact as projection on myCapSrv.Contacts;
}

service SalesOrderService{
    @odata.draft.enabled
    entity SalesOrder as projection on myCapSrv.SalesOrder;
    entity SalesItems as projection on myCapSrv.SalesItems;
}

annotate SalesOrderService.SalesOrder with @(
    UI: {
        SelectionFields : [
            salesNumber, customerName, customerCode , customerAddress
        ],
        LineItem:[
            {
                $Type: 'UI.DataField',
                Value: salesNumber
            },
            {
                $Type: 'UI.DataField',
                Value: customerName
            },
            {
                $Type: 'UI.DataField',
                Value: customerCode
            },
            {
                $Type: 'UI.DataField',
                Value: customerAddress
            }
        ],

        FieldGroup #BasicData:{
            $Type: 'UI.FieldGroupType',
            Data:[
                {
                    $Type: 'UI.DataField',
                    Value: salesNumber
                },
                {
                    $Type: 'UI.DataField',
                    Value: customerName
                },
                {
                    $Type: 'UI.DataField',
                    Value: customerCode
                },
                {
                    $Type: 'UI.DataField',
                    Value: customerAddress
                },
                {
                    $Type: 'UI.DataField',
                    Value: createdAt
                },
                {
                    $Type: 'UI.DataField',
                    Value: modifiedAt
                }
            ]
        },
        Facets:[
            {
                $Type: 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#BasicData',
                Label: 'Sales Order Info',
                ID: 'headerID'
            },
            {
                $Type: 'UI.ReferenceFacet',
                Target: 'salesItem/@UI.LineItem',
                Label: 'Sales Items Info',
                ID: 'headerItemID'
            }
        ]
    }
){
    ID @UI: {Hidden};
    salesNumber @title : 'Sales Order';
    customerName @title : 'Customer Name';
    customerCode @title : 'Customer Code';
    customerAddress @title: 'Customer Address';
}

annotate SalesOrderService.SalesItems with @(
    UI:{
        LineItem: [
            {
                $Type: 'UI.DataField',
                Value: itemCategory
            },
            {
                $Type: 'UI.DataField',
                Value: IS_Avaliable
            },
            {
                $Type: 'UI.DataField',
                Value: itemCreationDate
            },
        ],

        FieldGroup #BasicData:{
            $Type: 'UI.FieldGroupType',
            Data:[
                {
                    $Type: 'UI.DataField',
                    Value: itemCategory
                },
                {
                    $Type: 'UI.DataField',
                    Value: IS_Avaliable
                },
                {
                    $Type: 'UI.DataField',
                    Value: itemCreationDate
                }
            ]
        },
        Facets: [
            {
                $Type: 'UI.ReferenceFacet',
                Target: '@UI.FieldGroup#BasicData',
                Label: 'Sales Items',
                ID: 'salesItemID'
            }
        ],

    }
){
    ID @UI: {Hidden};
    itemCategory @title : 'Item Category';
    IS_Avaliable @title : 'IS Avaliable';
    itemCreationDate @title : 'Item Creation Date'
};
