class LandingController < ApplicationController
  include Accessible
  before_action :check_resource
  skip_before_action :authenticate_user_or_admin!
  def index
  end
end