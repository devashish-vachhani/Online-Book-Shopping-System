class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up(resource_name, resource)
  end

  def after_sign_up_path_for(resource)
    :new_user_session # Or :prefix_to_your_route
  end

end