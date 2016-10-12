class HomepagesController < ApplicationController

  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
    @invoice = Invoice.new
    @invoices = Invoice.all
    @paid_invoices = @invoice.get_all_paid_invoices
    @all_incomes = @invoice.get_all_paid_invoices_amount
    @this_week_invoices = @invoice.get_this_week_paid_invoices.all.size
    @last_week_invoices = @invoice.get_last_week_paid_invoices.all.size
    @this_week_incomes = @invoice.get_this_week_paid_invoices_amount
    @last_week_incomes = @invoice.get_last_week_paid_invoices_amount

    # Customer
    @customer = Customer.new
    @customers = Customer.all
    @this_week_customers = @customer.get_this_week_customer_number.all
    @days_since_account_created = Date.today - (current_account.created_at).to_date
    @customers_per_day = '%.2f' % (@customers.size.to_f/@days_since_account_created.to_f)
  end

  def landing_page
    @contact = Contact.new
  end

end
