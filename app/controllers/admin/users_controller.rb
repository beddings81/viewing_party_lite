class Admin::UsersController < Admin::BaseController
  def show
    @user = User.find(params[:id])
    @viewing_parties = @user.viewing_parties
  end
end