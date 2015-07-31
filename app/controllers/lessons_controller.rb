class LessonsController < ApplicationController
  def index
    @category = Category.find params[:id]
    @lessons = @category.lessons
  end

  def show
    @lesson = Lesson.find params[:id]
    @words = @lesson.words
    @mark = @lesson.num_correct_answer
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

  def update
    # byebug
    @lesson = Lesson.find params[:id]
    @lesson.update lesson_params
    # @category = @lesson.category
    # @words = @lesson.words
    # @words.each do |word|
    #   @result = @lesson.results.build
    #   @result.word = word
    #   @result.answer_id = lesson_params[:words_attributes]["#{word.id}"][:id]
    #   @result.save
    # end

    # if @lesson.update lesson_params
    #   redirect_to category_lesson_path @category, @lesson
    # else
    #   redirect_to categories_path
    # end
  end

  private
  def lesson_params
    params.require(:lesson).permit results_attributes: [:word_id, :answer_id]
  end
end
