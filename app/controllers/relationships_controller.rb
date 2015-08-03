class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find params[:user_id]
    if Settings.relationships.include?(params[:relationship])
      @title = params[:relationship]
      @users = @user.send(params[:relationship]).paginate page: params[:page]
    else
      redirect_to request.referer
    end
  end

  def create
    @user = User.find params[:followed_id]
    current_user.follow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow @user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end
end
