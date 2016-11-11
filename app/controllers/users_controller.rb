class UsersController < ApplicationController

  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end
end