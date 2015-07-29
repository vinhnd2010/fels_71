class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.order("name").paginate page: params[:page],
      per_page: Settings.paginate_per_page
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      respond_to do |format|
        format.html do
          flash[:success] = t "categories.CreateSuccess"
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      flash[:danger] = t "categories.createcatfails"
      redirect_to admin_categories_path
    end
  end

  def edit
  end

  def update
    if @category.update category_params
      flash[:success] = t "categories.categoryupdate"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "categories.categorydelete"
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      flash[:danger] = t "DestroyFail"
      redirect_to admin_categories_path
    end
  end

  private
  def find_category
     @category = find_object_model Category, params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
