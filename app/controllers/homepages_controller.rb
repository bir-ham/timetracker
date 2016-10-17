class HomepagesController < ApplicationController

  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
    @invoice = Invoice.new
    @all_incomes = @invoice.get_all_paid_invoices_amount
  end

  def landing_page
    @contact = Contact.new
  end

end
