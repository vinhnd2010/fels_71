class UsersController < ApplicationController
  before_action :logged_in_user, only: :show

  def index
    @users = User.order("name").paginate page: params[:page], per_page: 18
  end

  def show
    @user = find_object_model User, params[:id]
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def correct_user
    @user = find_object_model User, params[:id]
    redirect_to root_url unless current_user = @user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "user.pleaselogin"
      redirect_to login_url
    end
  end

  def verify_admin
    if logged_in? && current_user.admin?
      flash[:danger] = t "user.denied"
      redirect_to root_url
    else
      store_location
      flash[:danger] = t "user.pleaselogin"
      redirect_to login_url
    end
  end
end
