$(function() {
    $('#container').highcharts(chartData);
});

function loadCategories() {
    var string = JSON.stringify(violations);
    var mydata = JSON.parse(string);
    var json = mydata.files;
    return processCategories(json);
}

function processCategories(json) {
    var classNames = [];
    Object.keys(json).forEach(function(index) {
        if (json[index].hasOwnProperty("path")) {
            var pathString = json[index]["path"];
            var strippedPath = pathString.replace("/Users/vincekearney/Documents/MyProjects/iOS/LocalLeaders/LocalLeaders/", "");
            strippedPath = strippedPath.replace(".swift", "");
            classNames.push(strippedPath);
        }
    });

    return classNames;
}

function loadSeries() {
    var string = JSON.stringify(violations);
    var mydata = JSON.parse(string);
    var json = mydata.files;
    var allTheRules = getRules(json);
    var allRulesArray = Array.from(allTheRules).sort();
    var sortedRulesAndClasses = getOccurencesOfRules(json);

    for (var i = 0; i < sortedRulesAndClasses.length; i++) {
        var object = sortedRulesAndClasses[i];
        if (object.hasOwnProperty("rules")) {
            var keys = [];
            for (var key in object.rules) {
                keys.push(key);
            }

            allTheRules.forEach(function(value) {
                if(!keys.includes(value)) {
                    object.rules[value] = 0;
                }
            });
        } else {
            object.rules = {};
            allTheRules.forEach(function(value) {
                object.rules[value] = 0;
            });
        }
    }

    return getSeriesData(sortedRulesAndClasses, allRulesArray);
}

function getSeriesData(arrayOfStuff, rules) {
    var allSeriesData = [];
    for(var i = 0; i < rules.length; i++) {
        var theRule = rules[i];
        var thisSeriesJson = {};
        thisSeriesJson.name = theRule;
        thisSeriesJson.data = [];
        for(var index = 0; index < arrayOfStuff.length; index++) {
            var object = arrayOfStuff[index];
            var theCountOfThisRule = object.rules[theRule];
            thisSeriesJson.data.push(theCountOfThisRule);
        }

        allSeriesData.push(thisSeriesJson);
    }

    return allSeriesData;
}

function getOccurencesOfRules(json) {
    var allJsonData = [];

    Object.keys(json).forEach(function(index) {
        var jsonData = {};
        var object = json[index];

        if (object.hasOwnProperty("path")) {
            var pathString = object["path"];
            var strippedPath = pathString.replace("/Users/vincekearney/Documents/MyProjects/iOS/LocalLeaders/LocalLeaders/", "");
            strippedPath = strippedPath.replace(".swift", "");
            jsonData.path = strippedPath;
        }

        if (object.hasOwnProperty("violations")) {
            var violation = object["violations"];
            if (violation.length > 0 ) {
                var localRules = [];
                var rulesJson = {};
                jsonData.rules = {};
                for (var i = 0; i < violation.length; i++) {
                    var object = violation[i];
                    if (object.hasOwnProperty("rule")) {
                        var theRule = object.rule
                        if (!localRules.includes(theRule)) {
                            localRules.push(theRule);
                            rulesJson[theRule] = 1
                        } else {
                            var currentCount = rulesJson[theRule];
                            rulesJson[theRule] = currentCount + 1;
                        }
                    }
                }
                jsonData.rules = rulesJson;
            }
        }

        allJsonData.push(jsonData);
    });

    return allJsonData;
}

function getRules(json) {
    var ruleSet = new Set();
    Object.keys(json).forEach(function(index) {
        if (json[index].hasOwnProperty("violations")) {
            var violations = json[index]["violations"];
            for (var i in violations) {
                var object = violations[i];
                if (object.hasOwnProperty("rule")) {
                    ruleSet.add(object.rule);
                }
            }
        }
    });
    return ruleSet;
}

function testLoad() {
    loadSeries()
    return loadCategories();
}

var chartData = {
    chart: {
        type: 'bar'
    },
    title: {
        text: 'Tailor Violations Chart',
        x: -20 // Center
    },
    subtitle: {
        text: 'Chart to show the violations of each class that Tailor finds',
        x: -20
    },
    xAxis: {
        title: {
            text: 'Class Names'
        },
        categories: testLoad()
    },
    yAxis: {
        title: {
            text: 'Number of Violations'
        },
        plotLines: [{
            value: 0,
            width: 1,
            color: '#00B0FF'
        }]
    },
    tooltip: {
        valueSuffix: '',
    },
    plotOptions: {
        series: {
            stacking: 'normal'
        }
    },
    legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'middle',
        borderWidth: 0
    },
    series: loadSeries()
}
