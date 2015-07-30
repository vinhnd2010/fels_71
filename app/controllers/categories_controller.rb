class CategoriesController < ApplicationController
  before_action :logged_in_user

  def index
    @categories = Category.order("name")
      .paginate page: params[:page], per_page: Settings.paginate_per_page
  end

  def show
    @category = Category.find params[:id]
    @words = Word.in_category(params[:category_id]).not_learned(current_user)
      .paginate page: params[:page], per_page: Settings.paginate_per_page
  end
end
