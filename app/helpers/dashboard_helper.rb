module DashboardHelper

  def paid_invoices_chart_data
    paid_items = Item.paid_items_grouped_by_week(4.weeks.ago)
    paid_tasks = Task.paid_tasks_grouped_by_week(4.weeks.ago)

    (4.weeks.ago.to_date..Date.today).select(&:monday?).map do |date|
      items = paid_items[date]
      tasks = paid_tasks[date]

      items_total = 0
      unless items.nil?
        for item in items
          items_total += item.total
        end
      end

      tasks_total = 0
      unless tasks.nil?
        for task in tasks
          tasks_total += task.total
        end
      end

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
      else
        date_name = 'Week ' +date.strftime("%U").to_i.to_s
      end

      {
        date_of_an_invoice: date_name,
        paid: items_total + tasks_total
      }
    end
  end

  def pending_invoices_chart_data
    pending_items = Item.pending_items_grouped_by_week(4.weeks.ago)
    pending_tasks = Task.pending_tasks_grouped_by_week(4.weeks.ago)

    (4.weeks.ago.to_date..Date.today).select(&:monday?).map do |date|
      items = pending_items[date]
      tasks = pending_tasks[date]

      items_total = 0
      unless items.nil?
        for item in items
          items_total += item.total
        end
      end

      tasks_total = 0
      unless tasks.nil?
        for task in tasks
          tasks_total += task.total
        end
      end

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
      else
        date_name = 'Week ' +date.strftime("%U").to_i.to_s
      end

      {
        date_of_an_invoice: date_name,
        paid: items_total + tasks_total
      }
    end
  end

  def overdue_invoices_chart_data
    overdue_items = Item.overdue_items_grouped_by_week(4.weeks.ago)
    overdue_tasks = Task.overdue_tasks_grouped_by_week(4.weeks.ago)

    (4.weeks.ago.to_date..Date.today).select(&:monday?).map do |date|
      items = overdue_items[date]
      tasks = overdue_tasks[date]

      items_total = 0
      unless items.nil?
        for item in items
          items_total += item.total
        end
      end

      tasks_total = 0
      unless tasks.nil?
        for task in tasks
          tasks_total += task.total
        end
      end

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
      else
        date_name = 'Week ' +date.strftime("%U").to_i.to_s
      end

      {
        date_of_an_invoice: date_name,
        paid: items_total + tasks_total
      }
    end
  end

  def projects_status_chart_data
    projects_by_week = Project.grouped_by_week(4.weeks.ago)

    (4.weeks.ago.to_date..Date.today).select(&:monday?).map do |date|
      projects = projects_by_week[date]

      new_projects = 0
      ongoing_projects = 0
      finished_projects = 0
      delayed_projects = 0
      unless projects.nil?
        for project in projects
          if project.status == 'NEW'
            new_projects +=1
          elsif project.status == 'ONGOING'
            ongoing_projects +=1
          elsif project.status == 'FINISHED'
            finished_projects +=1
          elsif project.status == 'DELAYED'
            delayed_projects +=1
          end
        end
      end

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
      else
        date_name = 'Week ' +date.strftime("%U").to_i.to_s
      end

      {
        date_name: date_name,
        new_projects: new_projects,
        ongoing_projects: ongoing_projects,
        finished_projects: finished_projects,
        delayed_projects: delayed_projects,
        total: new_projects + ongoing_projects + finished_projects + delayed_projects
      }
    end
  end

  def sales_status_chart_data
    sales_by_week = Sale.grouped_by_week(4.weeks.ago)

    (4.weeks.ago.to_date..Date.today).select(&:monday?).map do |date|
      sales = sales_by_week[date]

      preparing_sales = 0
      waiting_sales = 0
      delivered_sales = 0
      unless sales.nil?
        for sale in sales
          if sale.status == 'PREPARING'
            preparing_sales +=1
          elsif sale.status == 'WAITIING'
            waiting_sales +=1
          elsif sale.status == 'DELIVERED'
            delivered_sales +=1
          end
        end
      end

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
      else
        date_name = 'Week ' +date.strftime("%U").to_i.to_s
      end

      {
        date_name: date_name,
        preparing_sales: preparing_sales,
        waiting_sales: waiting_sales,
        delivered_sales: delivered_sales,
        total: preparing_sales + waiting_sales + delivered_sales
      }
    end
  end

  def customers_chart_data
    all_customers = Customer.joins(:sales, :projects)
    days_since_account_creation = Date.today - (current_account.created_at).to_date
    weeks_since_account_creation = days_since_account_creation/7
    # Protect zero divison
    if weeks_since_account_creation == 0
      weeks_since_account_creation = 1
    end  
    customers_visist_average = '%.2f' % (all_customers.size.to_f/weeks_since_account_creation.to_f)
    customers_by_week = Customer.grouped_by_week(4.weeks.ago)

    (4.weeks.ago.to_date..Date.today).select(&:monday?).map do |date|
      customers = customers_by_week[date]
      customers_size = 0
      unless customers.nil?
        customers_size = customers.size
      end

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
      else
        date_name = 'Week ' +date.strftime("%U").to_i.to_s
      end

      {
        date_name: date_name,
        customers_visit_per_week: customers_size,
        customers_visit_average: customers_visist_average
      }
    end
  end

end