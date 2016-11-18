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
      eventLimit: true,
      events: '/events.json'
      select: (start, end) ->
        $.getScript '/events/new', ->
          $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm")+ ' - ' +
            moment(start).format("MM/DD/YYYY HH:mm")).date_range_picker()
          $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'))
          $('.end_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'))

        calendar.fullCalendar('unselect')  
    }

$(document).on 'ready', initialize_calendar