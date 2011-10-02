$(function(){
    $('#archive').imagesLoaded( function(){
        $('#archive article img').tipsy({fade: true, gravity: $.fn.tipsy.autoNS});
        $(this).isotope({
            itemSelector : 'article'
        });
    });

    $('a.nav-link').live('click', function() {
        history.pushState(null, $("#photo-wrapper h1").text(), this.href);
        slideTo(this.href);
        return false;
    });
    $(document).keyup(function(event) {
        var direction = null;
        if (event.keyCode == 37) {
            direction = 'prev';
        } else if (event.keyCode == 39) {
            direction = 'next';
        }
        if (direction != null) {
            $("a#"+direction).click();
        }
    });
    var popped = ('state' in window.history), initialURL = location.href
    $(window).bind('popstate', function() {
        var initialPop = !popped && location.href == initialURL
        popped = true
        if ( initialPop ) return
        slideTo(location.pathname);
    })
});

function slideTo (location) {
    $.get(location, function(data) {
        var photo_wrapper = $("#photo-wrapper");
        var old_photo = $("article",photo_wrapper);
        var new_photo = $(data).find("article");
        var new_nav = $(data).find("nav");
        var window_width = $(window).width();
        var left_offset = 0 - window_width;

        if (old_photo.find("img").data('image-position') > new_photo.find("img").data('image-position')) {
            new_photo.css({
                left: left_offset
            });
            old_photo.animate({left: window_width}, 'slow', function(){
                photo_wrapper.prepend(new_photo);
                old_photo.remove();
                new_photo.animate({left: 0}, 'slow');
            });
        } else {
            new_photo.css({
                left: window_width
            });
            old_photo.animate({left: left_offset}, 'slow', function(){
                photo_wrapper.prepend(new_photo);
                old_photo.remove();
                new_photo.animate({left: 0}, 'slow');
            });
        }
        $("nav").replaceWith(new_nav);
        document.title = document.title.split("-")[0] + "- " +new_photo.find("h1").text();
    });
}