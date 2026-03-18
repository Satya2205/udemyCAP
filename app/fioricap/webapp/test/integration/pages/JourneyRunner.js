sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"com/cap/fioricap/test/integration/pages/SalesOrderList",
	"com/cap/fioricap/test/integration/pages/SalesOrderObjectPage"
], function (JourneyRunner, SalesOrderList, SalesOrderObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('com/cap/fioricap') + '/test/flp.html#app-preview',
        pages: {
			onTheSalesOrderList: SalesOrderList,
			onTheSalesOrderObjectPage: SalesOrderObjectPage
        },
        async: true
    });

    return runner;
});

