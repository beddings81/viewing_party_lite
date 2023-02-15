class Admin::BaseController < ApplicationController
  before_action :require_admin

   private
    def require_admin
      flash[:error] = "You are not authorized to access this page"
      redirect_to root_path unless current_admin?
    end
end