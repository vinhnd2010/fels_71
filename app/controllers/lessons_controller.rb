class LessonsController < ApplicationController
  def index
    @category = Category.find params[:id]
    @lessons = @category.lessons
  end

  def show
    @lesson = Lesson.find params[:id]
    @words = @lesson.words
  end

  def create
    @category = Category.find params[:category_id]
    @lesson = @category.lessons.build user: current_user,
      name: t("lesson.name", count: @category.lessons.count + 1),
      description: t("lesson.description")
    if @lesson.save
      flash[:success] = t "lesson.flash.success"
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = t "lesson.flash.fail"
      redirect_to request.referrer
    end
  end
end
