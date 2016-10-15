jQuery ->
  # Add helper to format timestap data
  Date::formatMMDDYYY = ->
    @getDate() + '/' + (@getMonth() + 1) + '/' + @getFullYear()


  # JSON
  paid_invoices_data = []
  paid_invoices_labels = []
  paid_invoices = $('#incomes').data('paid-invoices')

  pending_invoices_data = []
  pending_invoices = $('#invoicing-performance').data('pending-invoices')

  overdue_invoices_data = []
  overdue_invoices = $('#invoicing-performance').data('overdue-invoices')

  paid_invoices.forEach (item) ->
    paid_invoices_labels.push(item.date_of_an_invoice)
    paid_invoices_data.push(parseFloat(item.paid))
    return
  pending_invoices.forEach (item) ->
    pending_invoices_data.push(parseFloat(item.paid))
    return
  overdue_invoices.forEach (item) ->
    overdue_invoices_data.push(parseFloat(item.paid))
    return

  # invoicing performance
  new Chart($('#invoicing-performance'), {
    type: 'bar',
    data: {
      labels: paid_invoices_labels,
      datasets: [{
        label: 'Paid'
        data: paid_invoices_data,
        backgroundColor: "rgba(63,103,126,1)",
        hoverBackgroundColor: "rgba(50,90,100,1)"
      },{
        label: 'Pending'
        data: pending_invoices_data,
        backgroundColor: "rgba(163,103,126,1)",
        hoverBackgroundColor: "rgba(140,85,100,1)"
      },{
        label: 'Overdue'
        data: overdue_invoices_data,
        backgroundColor: "rgba(63,203,226,1)",
        hoverBackgroundColor: "rgba(46,185,235,1)"
      }]
    },
    options: {
      hover :{
        animationDuration:0
      },
      legend: {
        lineWidth: 0
      },
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero:true
          }
          stacked: true,
          barThickness: 10,
        }],
        xAxes: [{
          stacked: true,
          barThickness: 10,
        }]
      }
    }
  });

  # Incomes
  data = {
    type: 'line',
    data: {
      labels : paid_invoices_labels,
      datasets : [{
        backgroundColor           : "rgb(125,164,13)",
        borderColor            : "rgb(125,164,13)",
        data                  : paid_invoices_data
      }]
    }
    options: {
      legend: {
        display: false,
        labels: {
          display: false
        }
      },
      scales: {
        xAxes: [{
          display: false
        }]
        yAxes: [{
          paddingLeft: -10
          margins: {
            left: -10,
            bottom: -10,
          }
        }]
      }
    }

  }

  new Chart($('#incomes'), data)
