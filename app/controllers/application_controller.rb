class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery with: :exception
  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = t "access_denied"
    redirect_to root_url, alert: exception.message
  end

  def find_object_model model, id
    begin
      model.find id
    rescue ActiveRecord::RecordNotFound
      flash[:danger] =  t("flash.notfound", model: model)
      redirect_to current_user.admin? ? admin_root_path : root_path
    end
  end

  def redirect_logged_in_user
    redirect_to(root_url) if current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "flash.user.mustlogin"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "flash.user.permistion"
      redirect_to root_url
    end
  end
end
