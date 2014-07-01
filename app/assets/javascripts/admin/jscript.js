
$(document).ready(function () {
  $("input, textarea").data("data-toggle","tooltip");
  $("input, textarea").tooltip();
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
    data: '/tags/list.json'
  });
});