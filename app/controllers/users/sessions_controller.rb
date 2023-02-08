class Users::SessionsController < Devise::SessionsController
  # include Accessible
  # skip_before_action :check_resource, only: :destroy

  def after_sign_in_path_for(resource)
    authenticated_root_path
  end
end