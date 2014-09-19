function parseArticles(at){
 $.ajax({
    url: "/admin/articles/the_articles?article_type="+at,
    type: "GET",
    success: function(html) {
      $("#articles_data").html(html);
    },
    error: function( xhr, status, errorThrown ) {
      alert( "Sorry, there was a problem!" );
    }
  });
}

var ArticlesController = Paloma.controller('Admin/Articles');
ArticlesController.prototype.load_data = function(){
  parseArticles(this.params['at']);
};
