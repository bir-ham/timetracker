class RegistrationsController < Devise::RegistrationsController
  
  protected

  def update_resource(resource, user_params)
    resource.update_with_password(user_params)
  end

  def after_update_path_for(resource)
    current_account
  end

  

end