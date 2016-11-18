initialize_calendar = ->
  $('.calendar').each ->
    calendar = $(this)
    calendar.fullCalendar {
      header: {
        left: 'prev, next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      }, 
      selectabel: true,
      selectHelper: true,
      editable: true,
      eventLimit: true
    }

$(document).on 'ready', initialize_calendar