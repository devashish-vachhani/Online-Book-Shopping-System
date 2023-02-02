class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_resource, except: [:new, :create]

  protected def after_update_path_for(resource)
    admins_authenticated_root_path
  end
end