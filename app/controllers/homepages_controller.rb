class HomepagesController < ApplicationController

  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
    # Items and Tasks
    @all_incomes = Item.all_paid_items + Task.all_paid_tasks

    # Invoices
    unpaid_invoices = Invoice.all_unpaid_invoices_by_status
    @pending_invoices = unpaid_invoices['pending']
    @overdue_invoices = unpaid_invoices['overdue']

    # Projects
    @new_delayed_projects_count = Project.all_new_delayed_by_status

    # Sales
    @waiting_sales_count = Sale.all_waiting_by_status

    # Invited Users Invoices
    @invited_users_invoices = Invoice.unpaid_invoices_by_invited_users

    # Ransack link search
    @Projects = Sale.ransack(params[:Projects])
    @Projects = @Projects.result(distinct: true)

    @sales = Sale.ransack(params[:sales])
    @sales = @sales.result(distinct: true)
  end

  def landing_page
    @contact = Contact.new
  end

end
