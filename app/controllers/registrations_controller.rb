class RegistrationsController < Devise::RegistrationsController
  
  protected

  def update_resource(resource, user_params)
    user_params.delete :current_password
    resource.update_without_password(user_params)
  end

  def after_update_path_for(resource)
    current_account
  end

  def user_params 
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end