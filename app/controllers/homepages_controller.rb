class HomepagesController < ApplicationController
  
  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def dashboard
  
  end

  def landing_page
    @contact = Contact.new
  end  
  
end
