jQuery ->
  # Add helper to format timestap data
  Date::formatMMDDYYY = ->
    @getDate() + '/' + (@getMonth() + 1) + '/' + @getFullYear()

  # invoicing performance
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

  new Chart($('#invoicing-performance'), {
    type: 'bar',
    data: {
      labels: paid_invoices_labels,
      datasets: [{
        label: 'Paid'
        data: paid_invoices_data,
        backgroundColor: "rgb(125,164,13)",
        hoverBackgroundColor: "rgb(148,168,13)"
      },{
        label: 'Pending'
        data: pending_invoices_data,
        backgroundColor: "rgb(240,115,15)",
        hoverBackgroundColor: "rgb(241,149,70)"
      },{
        label: 'Overdue'
        data: overdue_invoices_data,
        backgroundColor: "rgb(190,10,10)",
        hoverBackgroundColor: "rgb(190,59,10)"
      }]
    },
    options: {
      legend: {
        label: {
          border: false
        }
      }
    }
  });

  # Projects doughnut chart
  two_weeks_projects = $('#projects').data('two-weeks-projects')

  new Chart($('#projects'), {
    type: 'doughnut',
    data: {
      labels: ['NEW', 'PENDING', 'FINISHED', 'OVERDUE'],
      datasets: [{
        data: [two_weeks_projects.new_projects, two_weeks_projects.delayed_projects,
          two_weeks_projects.ongoing_projects, two_weeks_projects.finished_projects],
        backgroundColor: ["#199CD5", "#F0730F", "#7DA40D", "#be0a0a"]
      }]
    },
    options: {
      legend: {
        display: false,
        labels: {
          display: false
        }
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


