initialize_calendar = ->
  $('.calendar').each ->
    calendar = $(this)
    calendar.fullCalendar {}

$(document).on 'ready', initialize_calendar