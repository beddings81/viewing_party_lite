class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save(user_params)
      redirect_to welcome_index_path
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
    if user.authenticate(params[:password])
      flash[:notice] = "Welcome, #{user.email}!"
      redirect_to user_dashboard_index_path(user)
    else
      flash[:notice] = "Your password does not match."
      render :login_form
    end
  end

  private
  def user_params
    params[:email].downcase!
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
