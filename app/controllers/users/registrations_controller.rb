class Users::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_resource, except: [:new, :create]


  def after_sign_up_path_for(resource)
    users_authenticated_root_path
  end

  protected def after_update_path_for(resource)
    users_authenticated_root_path
  end
end