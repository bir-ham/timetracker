jQuery ->
  # Add helper to format timestap data
  Date::formatMMDDYYY = ->
    @getDate() + '/' + (@getMonth() + 1) + '/' + @getFullYear()

  new Chart($('#invoicing-performance'), {
    type: 'bar',
    data: {
      labels: ["2014", "2013", "2012", "2011"],
      datasets: [{
        label: 'Paid'
        data: [727, 589, 537, 543],
        backgroundColor: "rgba(63,103,126,1)",
        hoverBackgroundColor: "rgba(50,90,100,1)"
      },{
        label: 'Pending'
        data: [238, 553, 746, 884],
        backgroundColor: "rgba(163,103,126,1)",
        hoverBackgroundColor: "rgba(140,85,100,1)"
      },{
        label: 'Overdue'
        data: [1238, 553, 746, 884],
        backgroundColor: "rgba(63,203,226,1)",
        hoverBackgroundColor: "rgba(46,185,235,1)"
      }]
    },
    options: {
      hover :{
        animationDuration:0
      },
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero:true
            fontSize:11
          }
          stacked: true
        }]
        xAxes: [{
          stacked: true
        }]
      }
    }
  });


  income_data = []
  income_labels = []
  incomes = $('#incomes').data('incomes')

  incomes.forEach (item) ->
    income_labels.push(item.date_of_an_invoice)
    income_data.push(parseFloat(item.paid))
    return

  # Incomes
  data = {
    type: 'line',
    data: {
      labels : income_labels,
      datasets : [{
        fillColor             : "rgba(151,187,205,0.2)",
        strokeColor           : "rgba(151,187,205,1)",
        pointColor            : "rgba(151,187,205,1)",
        pointStrokeColor      : "#fff",
        pointHighlightFill    : "#fff",
        pointHighlightStroke  : "rgba(151,187,205,1)",
        data                  : income_data
      }]
    }
    options: {
      scales: {
        xAxes: [{
          display: false,
          position: 'bottom'
        }],
        yAxes: {
          left: 5,
          bottom: 5
        }
      }
    }

  }

  new Chart($('#incomes'), data)
