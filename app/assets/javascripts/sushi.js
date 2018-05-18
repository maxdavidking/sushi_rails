$(document).on("turbolinks:load",function(){
  $(".sushi_new").hide();
  $(".validsushi_new").hide();

  $(".sushi_button").click( function (){
    $(".sushi_new").show();
    $(".validsushi_new").hide();
  });

  $(".validsushi_button").click( function (){
    $(".validsushi_new").show();
    $(".sushi_new").hide();
  });
});
