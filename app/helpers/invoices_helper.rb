module InvoicesHelper

  def paid_invoices_chart_data
    (4.weeks.ago.to_date..Date.today).select(&:sunday?).each_with_index.map do |date, index|
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
    (4.weeks.ago.to_date..Date.today).select(&:sunday?).each_with_index.map do |date, index|
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
    (4.weeks.ago.to_date..Date.today).map do |date|
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

end