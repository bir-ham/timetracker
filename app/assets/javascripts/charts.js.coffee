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

  paid_invoices.forEach (invoice) ->
    paid_invoices_labels.push(invoice.date_of_an_invoice)
    paid_invoices_data.push(parseFloat(invoice.paid))
    return
  pending_invoices.forEach (invoice) ->
    pending_invoices_data.push(parseFloat(invoice.paid))
    return
  overdue_invoices.forEach (invoice) ->
    overdue_invoices_data.push(parseFloat(invoice.paid))
    return

  invoiceOptions = {
    scaleBeginAtZero : true,
    scaleShowGridLines : true,
    scaleGridLineColor : "rgba(0,0,0,.05)",
    scaleGridLineWidth : 1,
    barShowStroke : true,
    barStrokeWidth : 1,
    barValueSpacing : 5,
    barDatasetSpacing : 1,
    responsive:true,
    options: {
      legend: {
        borderWidth: false
      }
      scales: {
        xAxes: [{
          ticks: {
            beginAtZero:true
          },
          gridLines: {
            display:false
          }
        }]
      }
    }
  }

  invoicesData = {
    type: 'bar',
    data: {
      labels: paid_invoices_labels,
      datasets: [{
        label: 'Paid'
        data: paid_invoices_data,
        backgroundColor: "rgba(125,164,13,0.75)",
        borderWidth     : 2,
      },{
        label: 'Pending'
        data: pending_invoices_data,
        backgroundColor: "rgba(240,115,15,0.75)",
        borderWidth     : 2,
      },{
        label: 'Overdue'
        data: overdue_invoices_data,
        backgroundColor: "rgba(190,10,10,0.75)",
        borderWidth     : 2,
      }]
    }
  }
  new Chart($('#invoicing-performance'), invoicesData, invoiceOptions)

  # Projects doughnut chart
  two_weeks_projects = $('#projects').data('two-weeks-projects')
  new_projects = two_weeks_projects[0].new_projects + two_weeks_projects[1].new_projects
  delayed_projects = two_weeks_projects[0].delayed_projects + two_weeks_projects[1].delayed_projects
  ongoing_projects = two_weeks_projects[0].ongoing_projects + two_weeks_projects[1].ongoing_projects
  finished_projects = two_weeks_projects[0].finished_projects + two_weeks_projects[1].finished_projects

  projectsData =  {
    type: 'doughnut',
    data: {
      labels: ['NEW', 'PENDING', 'FINISHED', 'OVERDUE'],
      datasets: [{
        data: [new_projects, delayed_projects, ongoing_projects, finished_projects],
        backgroundColor: ["rgba(25,156,213, 0.75)", "rgba(240,115,15, 0.75)", "rgba(125,164,13, 0.75)", "rgba(190,10,10, 075)"]
      }]
    },
    options: {
      animation: {
        animateScale: true,
        animateRotate: true
      }
      legend: {
        display: false,
        labels: {
          display: false,
        }
      }
    }
  }
  new Chart($('#projects'), projectsData)

  # Incomes
  incomesData = {
    type: 'line',
    data: {
      labels : paid_invoices_labels,
      datasets : [{
        backgroundColor: "rgba(125,164,13, 0.75)",
        borderColor: "rgba(125,164,13, 1)",
        borderWidth: 1,
        pointRadius: 2,
        pointBackgroundColor: "rgba(125,164,13, 1)",
        data: paid_invoices_data
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

  new Chart($('#incomes'), incomesData)

  # Customers
  customers = $('#customers').data('customers')
  customers_visit_per_week = []
  customers_visit_average = []
  customers_visit_labels = []
  console.log('Customers', customers_visit_per_week)
  customers.forEach (customer) ->
    customers_visit_average.push(customer.customers_visit_average)
    customers_visit_per_week.push(customer.customers_visit_per_week)
    customers_visit_labels.push(customer.date_name)

  customersData = {
    type: 'line',
    data: {
      labels : customers_visit_labels,
      datasets: [
        {
          borderColor: "#7DA40D",
          borderWidth: 1,
          fill: false,
          pointRadius: 2,
          pointBackgroundColor: "#7DA40D",
          data:  customers_visit_per_week
        },
        {
          borderColor: "#be0a0a",
          borderWidth: 1,
          fill: false,
          pointRadius: 2,
          pointBackgroundColor: "#be0a0a",
          data: customers_visit_average
        }
      ]
    },
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
      }
    }

  }
  new Chart($('#customers'), customersData)
