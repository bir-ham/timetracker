module DashboardHelper

  def paid_invoices_chart_data
    (4.weeks.ago.to_date..Date.today).select(&:sunday?).map do |date|
      sales = Sale.joins(:invoice).where(invoices: {status: 'PAID', date_of_an_invoice: date..date+7})
      projects = Project.joins(:invoice).where(invoices: {status: 'PAID', date_of_an_invoice: date..date+7})

      paid_items = 0
      for sale in sales
        for item in sale.items
          paid_items += item.total
        end
      end
      paid_tasks = 0
      for project in projects
        for task in project.tasks
          paid_tasks += task.total
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
        paid: paid_items + paid_tasks
      }
    end
  end

  def pending_invoices_chart_data
    (4.weeks.ago.to_date..Date.today).select(&:sunday?).map do |date|
      sales = Sale.joins(:invoice).where(invoices: {status: 'PENDING', date_of_an_invoice: date..date+7})
      projects = Project.joins(:invoice).where(invoices: {status: 'PENDING', date_of_an_invoice: date..date+7})

      paid_items = 0
      for sale in sales
        for item in sale.items
          paid_items += item.total
        end
      end
      paid_tasks = 0
      for project in projects
        for task in project.tasks
          paid_tasks += task.total
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
        paid: paid_items + paid_tasks
      }
    end
  end

  def overdue_invoices_chart_data
    (4.weeks.ago.to_date..Date.today).select(&:sunday?).map do |date|
      sales = Sale.joins(:invoice).where(invoices: {status: 'OVERDUE', date_of_an_invoice: date..date+7})
      projects = Project.joins(:invoice).where(invoices: {status: 'OVERDUE', date_of_an_invoice: date..date+7})

      paid_items = 0
      for sale in sales
        for item in sale.items
          paid_items += item.total
        end
      end
      paid_tasks = 0
      for project in projects
        for task in project.tasks
          paid_tasks += task.total
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
        paid: paid_items + paid_tasks
      }
    end
  end

  def two_weeks_projects_chart_data
    (2.weeks.ago.to_date..Date.today).select(&:sunday?).map do |date|
      projects = Project.where(created_at: date..date+7)

      new_projects = 0
      ongoing_projects = 0
      finished_projects = 0
      delayed_projects = 0
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

      date_name = ''
      if date.strftime("%U").to_i == Date.today.strftime("%U").to_i
        date_name = 'This week'
      elsif date.strftime("%U").to_i == 7.days.ago.to_date.strftime("%U").to_i
        date_name = 'Last week'
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

  def customers_chart_data
    all_customers = Customer.joins(:sales, :projects)
    days_since_account_creation = Date.today - (current_account.created_at).to_date
    weeks_since_account_creation = days_since_account_creation/7
    customers_visist_average = '%.2f' % (all_customers.size.to_f/weeks_since_account_creation.to_f)

    (4.weeks.ago.to_date..Date.today).select(&:sunday?).map do |date|
      customers = Customer.joins(:sales, :projects).where(created_at:  date..date+7)

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
        customers_visit_per_week: customers.size,
        customers_visit_average: customers_visist_average
      }
    end
  end

end