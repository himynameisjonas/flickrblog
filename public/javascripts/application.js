// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  
  $('#archive').imagesLoaded( function(){
    $(this).isotope({
      itemSelector : 'article'
    });
  });
});