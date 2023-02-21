class Admins::RegistrationsController < Devise::RegistrationsController
  include Accessible
  skip_before_action :check_resource, except: [:new, :create]
  skip_before_action :authenticate_user_or_admin!

  def new
    redirect_to root_path, alert: "New admin registrations are not allowed."
  end
end