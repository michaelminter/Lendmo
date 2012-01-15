// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require "chosen.jquery.min"

$(document).ready(function(){
  $(".chzn-select").chosen();
  
  $(".comment-link").click(function(){
    $(this).parent().children("li").children("form").show();
    $(this).hide();
  });
  
  $("ol.comments li").hover(function(){
    $(this).children(".timestamp.own").toggle();
    $(this).children(".delete").toggle();
  });
  
  $("#badge-notice").show().delay(5000).slideUp();
});
