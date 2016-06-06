class DashboardsController < ApplicationController
  #skip_before_filter :authenticate_user!, only: :index
  before_filter :authenticate_user!, only: :dashboard

  def index
  
  end
end  