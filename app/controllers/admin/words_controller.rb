class Admin::WordsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :find_word, except: [:index, :new, :create]

  def index
  end

  private
  def find_word
    @word = find_object_model Word, params[:id]
  end

  def word_params
    params.require(:word).permit :name, :category_id
  end
end
