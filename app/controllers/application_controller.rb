class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
end
