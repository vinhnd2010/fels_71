class UsersController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :index

  def index
    @users = User.order("name").paginate page: params[:page],
      per_page: Settings.paginate_per_page
  end

  def show
    @user = find_object_model User, params[:id]
    @activities = @user.activities.order(created_at: :DESC)
      .paginate page: params[:page], per_page: Settings.paginate_per_page
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = find_object_model User, params[:id]
  end

  def update
    user = User.find params[:id]
    if user.update_attributes user_params
      flash[:success] = t "flash.user.updated"
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
      flash[:danger] = t "flash.user.permistion"
      redirect_to root_url
    end
  end
end
