class Admin::UploadsController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin

  def create
    if file = params[:file]
      import_csv file
      flash[:success] = t "flash.import.successfully"
    else
      flash[:danger] = t "flash.import.required"
    end
    redirect_to admin_words_path
  end

  private
  def import_csv file
    CSV.open(file.path, "rt", headers: true).each do |row|
      category_name = row["category_name"]
      category_description = row["category_description"]
      word_name = row["word_name"]
      word_mean = row["word_mean"]
      is_correct = row["is_correct"]

      category = save_changes Category, {name: category_name},
        {name: category_name, description: category_description}
      word = save_changes Word, {name: word_name},
        {name: word_name, category_id: category.id}
      save_changes Answer, {content: word_mean, word_id: word.id},
        {word_id: word.id, content: word_mean, correct: is_correct}
    end
  end

  def save_changes model, fields_to_check, data
    if (existedCategory = model.find_by fields_to_check)
      existedCategory.update_attributes data
      existedCategory
    else
      model.create! data
    end
  end
end
