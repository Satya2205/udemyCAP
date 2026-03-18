sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheSalesOrderList.iSeeThisPage();
            Then.onTheSalesOrderList.onFilterBar().iCheckFilterField("Sales Order");
            Then.onTheSalesOrderList.onFilterBar().iCheckFilterField("Customer Name");
            Then.onTheSalesOrderList.onFilterBar().iCheckFilterField("Customer Code");
            Then.onTheSalesOrderList.onFilterBar().iCheckFilterField("Customer Address");
            Then.onTheSalesOrderList.onTable().iCheckColumns(4, {"salesNumber":{"header":"Sales Order"},"customerName":{"header":"Customer Name"},"customerCode":{"header":"Customer Code"},"customerAddress":{"header":"Customer Address"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheSalesOrderList.onFilterBar().iExecuteSearch();
            
            Then.onTheSalesOrderList.onTable().iCheckRows();

            When.onTheSalesOrderList.onTable().iPressRow(0);
            Then.onTheSalesOrderObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});