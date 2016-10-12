class HomepagesController < ApplicationController

  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
    @invoice = Invoice.new
    @invoices = Invoice.all
    @paid_invoices = @invoice.get_all_paid_invoices
    @all_incomes = @invoice.get_all_paid_invoices_amount
    @this_week_incomes = @invoice.get_this_week_paid_invoices_amount
    @last_week_incomes = @invoice.get_last_week_paid_invoices_amount
  end

  def landing_page
    @contact = Contact.new
  end

end
