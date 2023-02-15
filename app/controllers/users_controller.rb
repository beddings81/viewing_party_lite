class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save(user_params)
      session[:user_id] = user.id
      redirect_to root_path
      flash[:notice] = "Your account was succesfully created!"
    elsif params[:password] != params[:password_confirmation]
      flash[:notice] = "Passwords must match!"
      redirect_to new_user_path
    else
      flash[:notice] = "Error: All fields must be complete and email must be unique"
      redirect_to new_user_path
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.admin?
        flash[:notice] = "Welcome, #{user.email}! You have admin access."
        redirect_to admin_dashboard_index_path
      else
        flash[:notice] = "Welcome, #{user.email}!"
        redirect_to dashboard_index_path
      end
    else
      flash[:notice] = "Your password does not match."
      render :login_form
    end
  end

  def logout_user
    session.delete(:user_id)
    redirect_to root_path
  end

  private
  def user_params
    params[:email].downcase!
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
