jQuery ->
  # Add helper to format timestap data
  Date::formatMMDDYYY = ->
    @getDate() + '/' + (@getMonth() + 1) + '/' + @getFullYear()

  # Invoicing performance
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

  invoicesData = {
    type: 'bar',
    data: {
      labels: paid_invoices_labels,
      datasets: [{
        label: 'Paid'
        data: paid_invoices_data,
        backgroundColor: "rgba(125,164,13,0.75)",
        hoverBackgroundColor: "rgba(125,164,13,0.9)",
        borderWidth: 2
      },{
        label: 'Pending'
        data: pending_invoices_data,
        backgroundColor: "rgba(240,115,15,0.75)",
        hoverBackgroundColor: "rgba(240,115,15,0.9)",
        borderWidth: 2,
      },{
        label: 'Overdue'
        data: overdue_invoices_data,
        backgroundColor: "rgba(190,10,10,0.75)",
        hoverBackgroundColor: "rgba(190,10,10,0.9)",
        borderWidth: 2
      }]
    },
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
  new Chart($('#invoicing-performance'), invoicesData)

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

  # Projects doughnut chart
  projects_status = $('#projects').data('projects-status')
  new_projects = projects_status[0].new_projects + projects_status[1].new_projects + projects_status[2].new_projects + projects_status[3].new_projects
  delayed_projects = projects_status[0].delayed_projects + projects_status[1].delayed_projects + projects_status[2].delayed_projects + projects_status[3].delayed_projects
  ongoing_projects = projects_status[0].ongoing_projects + projects_status[1].ongoing_projects + projects_status[2].ongoing_projects + projects_status[3].ongoing_projects
  finished_projects = projects_status[0].finished_projects + projects_status[1].finished_projects + projects_status[2].finished_projects + projects_status[3].finished_projects

  projectsData =  {
    type: 'doughnut',
    data: {
      labels: ['NEW', 'PENDING', 'FINISHED', 'OVERDUE'],
      datasets: [{
        data: [new_projects, delayed_projects, ongoing_projects, finished_projects],
        backgroundColor: ["rgba(25,156,213,0.75)", "rgba(240,115,15,0.75)", "rgba(125,164,13,0.75)", "rgba(190,10,10,0.75)"]
        hoverBackgroundColor: ["rgba(25,156,213,1)", "rgba(240,115,15,1)",  "rgba(240,115,15,1)", "rgba(240,115,15,1)"]
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

  # Sales area graph
  sales_status = $('#sales').data('sales-status')

  sales_status_dates = []
  delivered_sales_data = []
  preparing_sales_data = []
  waiting_sales_data = []

  sales_status.forEach (sale) ->
    sales_status_dates.push(sales.date_name)
    delivered_sales_data.push(sale.delivered_sales)
    preparing_sales_data.push(sale.preparing_sales)
    waiting_sales_data.push(sale.waiting_sales)
    return

  salesData = {
    type: 'line',
    data: {
      labels: sales_status_dates,
      datasets: [{
        label: 'Delivered'
        backgroundColor: "rgba(125,164,13, 0.75)",
        borderColor: "rgba(125,164,13, 1)",
        borderWidth: 1,
        pointRadius: 2,
        pointBackgroundColor: "rgba(125,164,13, 1)",
        data: delivered_sales_data
      },{
        label: 'Preparing',
        backgroundColor: "rgba(240,115,15,0.75)",
        borderColor: "rgba(240,115,15,1)",
        borderWidth: 1,
        pointRadius: 2,
        pointBackgroundColor: "rgba(240,115,15,1)",
        data: preparing_sales_data
      },{
        label: 'Waiting',
        backgroundColor: "rgba(190,10,10,0.75)",
        borderColor: "rgba(190,10,10,1)",
        borderWidth: 1,
        pointRadius: 2,
        pointBackgroundColor: "rgba(240,115,15,1)",
        data: waiting_sales_data
      }]
    },
    options: {
      legend: {
        display: false,
        labels: {
          display: false,
        }
      },
      scales: {
        xAxes: [{
          display: false
        }]
      }
    }
  }
  new Chart($('#sales'), salesData)

  # Customers
  customers = $('#customers').data('customers')
  customers_visit_per_week = []
  customers_visit_average = []
  customers_visit_labels = []

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
