class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def find_object_model model, id
    begin
      model.find id
    rescue ActiveRecord::RecordNotFound
      flash[:danger] =  t("NotFound", model: model)
      redirect_to current_user.admin? ? admin_root_path : root_path
    end
  end

  def redirect_logged_in_user
    redirect_to(root_url) if current_user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "user.pleaselogin"
      redirect_to login_url
    end
  end

  def verify_admin
    unless current_user.admin?
      flash[:danger] = t "user.denied"
      redirect_to root_url
    end
  end
end
