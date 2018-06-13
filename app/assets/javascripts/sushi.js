$(document).on("turbolinks:load",function(){
  $(".sushi_new").hide();
  $(".validsushi_new").hide();

  $(".sushi_button").click( function (){
    $(".sushi_new").fadeIn(1000);
    $(".validsushi_new").hide();
  });

  $(".validsushi_button").click( function (){
    $(".validsushi_new").fadeIn(1000);
    $(".sushi_new").hide();
  });
});
