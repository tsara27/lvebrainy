// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function () {
  $("#save_as_draft").click(function() {
  	$("#status").val("1");
  });
  if ($('#hid_tags').val() == ""){
    vls=null;
  }
  else{
  vls = $('#hid_tags').val().split(",");
  }
  $('#tags_tag_name').magicSuggest({
    value: vls,
    allowFreeEntries: true,
    useCommaKey: true,
    method: 'get',
    data: '/admin/tags/list.json'
  });
  $('#summernote').summernote({
  	height: 300,   //set editable area's height
    codemirror: { // codemirror options
      theme: 'monokai'
    },
    toolbar: [
      ['style', ['bold', 'italic', 'underline', 'clear', 'style']],
      ['fontsize', ['fontsize']],
      ['color', ['color']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert',['link']],
      ['misc', ['codeview']]
    ]
  });

});

 var app = angular.module('main', ['ngTable']).controller('TableAngular', function($scope, $http, ngTableParams) {
  $http.get('/admin/my_thoughts/list.json').success(function (data) {
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