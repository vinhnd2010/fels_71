class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :index

  def index
    @users = User.order("name").paginate page: params[:page], per_page: 18
  end

  def show
    @user = find_object_model User, params[:id]
  end

  def edit
    @user = find_object_model User, params[:id]
  end

  def update
    user = User.find params[:id]
    if user.update_attributes user_params
      flash[:success] = t "user.PUpdate"
      redirect_to user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end

  def correct_user
    @user = find_object_model User, params[:id]
    unless current_user? @user
      flash[:danger] = t "user.denied"
      redirect_to root_url
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "user.denied"
      redirect_to root_url
    end
  end
end
