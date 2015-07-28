class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_user, except: [:index, :new, :create]

  def index
    @users = User.order("name").paginate page: params[:page], per_page: Settings.paginate_per_page
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.Usernew"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.PUpdate"
      redirect_to admin_user_path @user
    else
      render :edit
    end
  end

  def destroy
    unless current_user? @user
      @user.destroy
      destroy_result @user
    else
      flash[:success] = t "user.CanNotDestroy"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :role, :avatar
  end

  def find_user
    @user = find_object_model User, params[:id]
  end

  def destroy_result params
    if params.destroyed?
      flash[:success] = t "user.UserDel"
    else
      flash[:success] = t "DestroyFail"
    end
  end
end
