jQuery ->
  $('#menu-toggle').on 'click', ->
    $('body').toggleClass 'left-side-collapsed'
    $('.left-side-collapsed .link-container').addClass 'link-container-hidden'