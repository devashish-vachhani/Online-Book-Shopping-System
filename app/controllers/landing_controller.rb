class LandingController < ApplicationController
  include Accessible
  before_action :check_resource
  def index
  end
end