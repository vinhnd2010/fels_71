class LessonsController < ApplicationController
  before_action :find_category, only: [:show, :create, :update]
  before_action :find_lesson, only: [:show, :update]
  before_action :logged_in_user

  def index
  end

  def show
    @time_remaining = @lesson.time_remaining
    @is_time_over = @time_remaining < 0
    @mark = @lesson.num_of_correct_ans if @is_time_over
  end

  def create
    @words = @category.words.not_learned(current_user).random_questions
    @lesson = Lesson.new category_id: @category.id, user_id: current_user.id
    if @lesson.save
      flash[:success] = t "flash.lesson.created.success"
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = @lesson.errors.full_messages.join(", ")
      redirect_to category_path @category
    end
  end

  def update
    if @lesson.update lesson_params
      flash[:success] = t "flash.lesson.updated.success"
      redirect_to category_lesson_path @category, @lesson
    else
      flash[:danger] = t "flash.lesson.updated.fails"
      redirect_to categories_path
    end
  end

  private
  def find_category
    @category = Category.find params[:category_id]
  end

  def find_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.require(:lesson).permit results_attributes: [:id, :word_id, :answer_id]
  end
end
