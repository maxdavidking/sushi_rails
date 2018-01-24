$(document).on("turbolinks:click", function(){
  $(".spinner").show();
});

$(document).on("turbolinks:receive", function(){
  $(".spinner").hide();
});
