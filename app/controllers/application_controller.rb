class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    rescue_from CanCan::AccessDenied do |exception|
      if user_signed_in? || admin_signed_in?
        redirect_to authenticated_root_path, alert: "You are not authorized to access this page."
      else
        redirect_to root_path, alert: "You are not authorized to access this page."
      end
    end

    # before_action :authenticate_user!

    before_action :configure_permitted_parameters, if: :devise_controller?


    protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |user_params| user_params.permit(:email, :password, :password_confirmation, :username, :name, :address, :phone_number, :credit_card_number) }
      devise_parameter_sanitizer.permit(:sign_in) { |user_params| user_params.permit(:username, :password, :remember_me) }
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit( :email, :password, :password_confirmation, :username, :name, :address, :phone_number, :credit_card_number) }
    end

    def current_ability
      if current_user
        @current_ability ||=  Ability.new(current_user)
      elsif current_admin
        @current_ability ||=  Ability.new(current_admin)
      end
    end

end
