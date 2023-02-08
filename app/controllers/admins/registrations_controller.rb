class Admins::RegistrationsController < Devise::RegistrationsController
  # include Accessible
  # skip_before_action :check_resource, except: [:new, :create]

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    authenticated_root_path
  end
end