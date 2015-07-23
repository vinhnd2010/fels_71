class UsersController < ApplicationController

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

end
