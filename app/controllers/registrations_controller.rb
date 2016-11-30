class RegistrationsController < Devise::RegistrationsController
  
  protected

  def update_resource(resource, user_params)
    resource.update_with_password(user_params)
  end

  def after_update_path_for(resource)
    current_account
  end

  def user_params 
    params.require(:user).permit(:first_name, :last_name, :email, :current_password, :password, :password_confirmation)
  end

end