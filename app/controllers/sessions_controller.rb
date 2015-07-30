class SessionsController < ApplicationController
  before_action :redirect_logged_in_user, only: :new

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_with_role
    else
      flash[:danger] = t "flash.login.invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def redirect_with_role
    if current_user.admin?
      redirect_to admin_root_path
    else
      redirect_to root_url
    end
  end
end
