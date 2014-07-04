 var app = angular.module('main', ['ngTable']).controller('DemoCtrl', function($scope, $http, ngTableParams) {
    $http.get('/tutorials/list.json').success(function (data) {
    $scope.data = data;
             $scope.tableParams = new ngTableParams({
    page: 1,            // show first page
    count: 10           // count per page
    }, {
    total: $scope.data.length, // length of data
    getData: function($defer, params) {
        $defer.resolve($scope.data.slice((params.page() - 1) * params.count(), params.page() * params.count()));
    }});
             });

    });