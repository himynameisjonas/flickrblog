// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  
  $('#archive').imagesLoaded( function(){
    $('#archive article img').tipsy({fade: true, gravity: $.fn.tipsy.autoNS});
    $(this).isotope({
      itemSelector : 'article'
    });
  });
});