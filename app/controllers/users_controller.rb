class UsersController < ApplicationController

  def index
    @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end

  def edit
    @sale = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @item = Item.new
    if @user.update_attributes(user_params)
      redirect_to current_account, notice: I18n.t('users.update.success_update')
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end