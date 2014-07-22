 var app = angular.module('main', ['ngTable']).controller('TableAngular', function($scope, $http, ngTableParams) {
  $http.get('/tags/the_tags.json').success(function (data) {
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