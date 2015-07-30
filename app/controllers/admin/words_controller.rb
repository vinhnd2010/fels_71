class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_word, except: [:index, :new, :create]

  def index
    @categories = Category.all
    @word = Word.new
    Settings.answer.num_of_ans.times do
      @answer = @word.answers.build
    end
  end

  def create
    @word = Word.new word_params
    if @word.save
      respond_to do |format|
        format.html do
          flash[:success] = t "flash.word.created.success"
          redirect_to admin_words_path
        end
        format.js
      end
    else
      flash[:danger] = t "flash.word.created.fails"
      @categories = Category.all
      Settings.answer.num_of_ans.times do
        @answer = @word.answers.build
      end
      render :index
    end
  end

  def destroy
    if @word.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "flash.word.deleted.success"
          redirect_to admin_words_path
        end
        format.js
      end
    else
      flash[:danger] = t "flash.word.deleted.fails"
      redirect_to admin_words_path
    end
  end

  private
  def find_word
    @word = find_object_model Word, params[:id]
  end

  def word_params
    params.require(:word).permit :name, :category_id,
      answers_attributes: [:id, :content, :correct, :_destroy]
  end
end
