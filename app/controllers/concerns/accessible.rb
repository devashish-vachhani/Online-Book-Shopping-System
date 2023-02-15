module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_resource
  end

  protected

  def check_resource
    if admin_signed_in?
      flash.clear
      redirect_to(authenticated_root_path) and return
    elsif user_signed_in?
      flash.clear
      redirect_to(authenticated_root_path) and return
    end
  end
end