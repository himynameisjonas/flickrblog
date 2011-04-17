$(function(){
    $('#archive').imagesLoaded( function(){
        $('#archive article img').tipsy({fade: true, gravity: $.fn.tipsy.autoNS});
        $(this).isotope({
            itemSelector : 'article'
        });
    });

    $('a.nav-link').live('click', function() {
        // history.pushState({ path: this.path }, '', this.href);
        history.pushState({id: $(this).data('image-id')}, "hejhej",this.href);
        var direction = $(this).attr('id');
        slideTo(this.href, direction);
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
    $(window).bind('popstate', function() {
        if ($("img#photo").data("location-path") !== location.pathname) {
            slideTo(location.pathname);
        };
    })
});

function slideTo (location, direction) {
    $.get(location, function(data) {
        var photo_wrapper = $("#photo-wrapper");
        var old_photo = $("article",photo_wrapper);
        var new_photo = $(data).find("article");
        var new_nav = $(data).find("nav");
        var window_width = $(window).width();
        var left_offset = 0 - window_width;

        if (direction == "prev") {
            new_photo.css({
                left: left_offset
            });
            old_photo.animate({left: window_width}, 'slow', function(){
                photo_wrapper.prepend(new_photo);
                old_photo.remove();
                new_photo.animate({left: 0}, 'slow');
            });
        } else if(direction == "next") {
            new_photo.css({
                left: window_width
            });
            old_photo.animate({left: left_offset}, 'slow', function(){
                photo_wrapper.prepend(new_photo);
                old_photo.remove();
                new_photo.animate({left: 0}, 'slow');
            });
        } else {
            old_photo.slideUp("slow", function(){
                photo_wrapper.prepend(new_photo.css({display:"none"}));
                new_photo.slideDown("slow");
            });
        }
        $("nav").replaceWith(new_nav);
    });
}