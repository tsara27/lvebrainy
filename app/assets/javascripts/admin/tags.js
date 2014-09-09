$(document).ready(function () {
  $('form#new_tag')
    .on('ajax:success', function(xhr, data, status){
      console.log(status);
    })
    .on("ajax:error", function(xhr, status, error) {
      console.log(status);
  });

  function parseTags(){
  	$.ajax({
  		url: "/admin/tags/the_tags",
      type: "GET",
      success: function(html) {
        alert(!window.admin_tags);
        $("#tags_data").html(html);
      },
      error: function( xhr, status, errorThrown ) {
        alert( "Sorry, there was a problem!" );
        console.log( "Error: " + errorThrown );
        console.log( "Status: " + status );
        console.dir( xhr );
      }
    });
  }
});