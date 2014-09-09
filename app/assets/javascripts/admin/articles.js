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
  $('form#new_article')
    .on('ajax:success', function(xhr, data, status){
      console.log(status);
      $("form#new_article")[0].reset();
    })
    .on("ajax:error", function(xhr, status, error) {
      $("#notice").html("<div class='alert alert-success alert-dismissable'><button area-hidden='true' class='close' data-dismiss='alert' data-original-title='' title=''>×</button>Salah</div>");
      console.log(status);
      alert(error);
  });
});