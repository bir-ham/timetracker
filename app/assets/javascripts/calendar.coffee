initialize_calendar

initialize_calendar ->
  $('.calendar').each ->
  calendar.fullCalendar {}

$(document).on 'turbolinks:load', initialize_calendar
