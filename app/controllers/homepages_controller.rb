class HomepagesController < ApplicationController

  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
    @all_incomes = Item.all_paid_items + Task.all_paid_tasks
  end

  def landing_page
    @contact = Contact.new
  end

end
