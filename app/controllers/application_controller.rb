class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def find_object_model model, id
    begin
      model.find id
    rescue ActiveRecord::RecordNotFound
      flash[:danger] =  t("NotFound", model: model)
      redirect_to root_path
    end
  end

  def redirect_logged_in_user
    redirect_to(root_url) if current_user
  end
end
