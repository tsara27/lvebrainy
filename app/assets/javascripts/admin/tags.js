$(document).ready(function () {
  $(document)
    .on('ajax:send', function(xhr){
      $(this).html("<img src='/assets/images/ajax-loader.gif'/>")
    })
    .on('ajax:success', function(xhr, data, status){
      console.log(data);
    })
    .on("ajax:error", function(xhr, status, error) {
      console.log(status);})
    .on("ajax:complete", function(xhr, status) {
      console.log(xhr);
  });
});