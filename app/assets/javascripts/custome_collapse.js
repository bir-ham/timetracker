$(document).ready(function () {
  $('#menu-toggle').on('click', function () {
    $('body').toggleClass('left-side-collapsed');
    $('.left-side-collapsed .link-container').addClass('link-container-hidden');
  });
});