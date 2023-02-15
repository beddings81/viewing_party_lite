class Admin::DashboardController < Admin::BaseController

  def index
    @admin = current_user
    @users = User.where(role: 0)
  end
end