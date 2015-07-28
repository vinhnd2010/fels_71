class WordsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    filter_word
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        redirect_with_user_role
      end
    end
  end

  private
  def filter_word
    @categories = Category.all
    if params[:filter_state]
      @words = Word.in_category(params[:category_id]).send(params[:filter_state], current_user)
        .paginate page: params[:page], per_page: Settings.paginate_per_page
    else
      @words = Word.paginate page: params[:page], per_page: Settings.paginate_per_page
    end
  end

  def download_pdf words
    pdf = Prawn::Document.new
    table_data = Array.new
    table_data << ["Category name", "Category description", "Word", "Mean"]
    words.limit(words.count).each do |word|
      word.answers.correct.each do |answer|
        table_data << [word.category.name, word.category.description, word.name, answer.content]
      end
    end
    pdf.table table_data, width: 550, cell_style: {inline_format: true}
    send_data pdf.render, filename: "words.pdf", type: "application/pdf", disposition: "inline"
  end

  def redirect_with_user_role
    if current_user.teacher?
      download_pdf @words
    elsif current_user.admin?
      redirect_to admin_words_path
    else
      redirect_to words_path
    end
  end
end
