function parseTags(){
 $.ajax({
    url: "/admin/tags/the_tags",
    type: "GET",
    success: function(html) {
      $("#tags_data").html(html);
    },
    error: function( xhr, status, errorThrown ) {
      alert( "Sorry, there was a problem!" );
    }
  });
}

var TagsController = Paloma.controller('Admin/Tags');
TagsController.prototype.load_data = function(){
  parseTags();
};
