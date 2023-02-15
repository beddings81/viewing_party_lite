class ApplicationController < ActionController::Base
  helper_method :current_user, :current_admin?

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def validate_user
    if !current_user
      flash[:error] = "You must be logged in or registered to access this page"
      redirect_to root_path
    end
  end

  def validate_login
    if !current_user
      flash[:error] = "You must be logged in or registered to create a movie party"
      redirect_to movie_path(params[:movie_id])
    end
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
