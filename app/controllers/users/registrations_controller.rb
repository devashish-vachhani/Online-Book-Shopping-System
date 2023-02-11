class Users::RegistrationsController < Devise::RegistrationsController
  # include Accessible
  # skip_before_action :check_resource, except: [:new, :create]

  protected

  def after_sign_up_path_for(resource)
      authenticated_root_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    authenticated_root_path
  end
end