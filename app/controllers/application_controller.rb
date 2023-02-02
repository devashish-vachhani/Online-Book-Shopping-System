class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    # before_action :authenticate_user!

    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |user_params| user_params.permit(:email, :password, :password_confirmation, :username, :name, :address, :phone_number, :credit_card_number) }
      devise_parameter_sanitizer.permit(:sign_in) { |user_params| user_params.permit(:username, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :email, :password, :password_confirmation, :username, :name, :address, :phone_number, :credit_card_number, :current_password) }
    end
end
