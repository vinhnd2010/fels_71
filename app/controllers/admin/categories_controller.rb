class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def index
    @categories = Category.order("name").paginate page: params[:page], per_page: 18
  end

  def show
    @category = find_object_model Category, params[:id]
    @lessons = @category.lessons
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "categories.CreateSuccess"
      redirect_to admin_category_path @category
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
