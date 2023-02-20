class DashboardController < ApplicationController
  before_action :validate_user

  def index
    @user = current_user
    @viewing_parties = @user.viewing_parties
  end
end
