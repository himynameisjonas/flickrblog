// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  
  $('#archive').imagesLoaded( function(){
    $('#archive article img').tipsy({fade: true, gravity: $.fn.tipsy.autoNS});
    $(this).isotope({
      itemSelector : 'article'
    });
  });
  
  $('a.nav-link').live('click', function() {
    history.pushState({ path: this.path }, '', this.href)
    var direction = $(this).attr('id')
    slideTo(this.href, direction)
    return false
  })
});

function slideTo (location, direction) {
    $.get(location, function(data) {
      var old_photo = $("#main>article")
      var new_photo = $(data).find("#main>article")
      var window_width = $(window).width()
      var left_offset = 0 - window_width

      var new_nav = $(data).find("#nav")
      if (direction == "prev") {
          new_photo.css({
              left: left_offset
          })
          old_photo.animate({left: window_width}, 'slow', function(){
              old_photo.before(new_photo)
              old_photo.remove()
              new_photo.animate({left: 0}, 'slow');
          });
      } else {
          new_photo.css({
              left: window_width
          })
          old_photo.animate({left: left_offset}, 'slow', function(){
              old_photo.before(new_photo)
              old_photo.remove()
              new_photo.animate({left: 0}, 'slow');
          });
      }
      
      $("#nav").replaceWith(new_nav)
    })
}