class HomepagesController < ApplicationController

  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
    @all_incomes = Item.all_paid_items + Task.all_paid_tasks
    unpaid_invoices = Invoice.all_unpaid_invoices_by_status
    @pending_invoices =  unpaid_invoices['pending']
    @overdue_invoices =  unpaid_invoices['overdue']
  end

  def landing_page
    @contact = Contact.new
  end

end
