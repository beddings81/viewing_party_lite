class DiscoverController < ApplicationController
  before_action :validate_user
  
  def index
    @user = current_user
  end
end
