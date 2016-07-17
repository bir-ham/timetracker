$(window).load(function() {
  /* ==============================================
  1.NiceScroll
  =============================================== */
  jQuery("html").niceScroll({
    scrollspeed: 50,
    mousescrollstep: 38,
    cursorwidth: 7,
    cursorborder: 0,
    cursorcolor: '#038b98',
    autohidemode: false,
    zindex: 9999999,
    horizrailenabled: false,
    cursorborderradius: 0
  });

  $('.back-to-top').click(function(){
    $("html, body").animate({ scrollTop: 0 }, 1000);
    return false;
  });

});
/* ==============================================
2.Scroll to top
=============================================== */
$(window).scroll(function(){
  if ($(this).scrollTop() > 100) {
    $('.back-to-top').fadeIn();
  } else {
    $('.back-to-top').fadeOut();
  }
});
/* ==============================================
3.Navbar-Scroll
=============================================== */
//transperent nav
$(window).scroll(function() {
  if ($(".navbar").offset().top > 1) {
    $(".navbar-fixed-top").addClass("navbar-bg");
  } else {
    $(".navbar-fixed-top").removeClass("navbar-bg");
  }
});
/* ==============================================
4.Smooth Scroll To Anchor
=============================================== */
//jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
  $('.navbar a').bind('click', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top - 50
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
  });
});



