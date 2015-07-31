class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :lessons, through: :lesson_words
  has_many :lesson_words, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: ->a{a[:content].blank?}

  scope :in_category, ->category_id{where category_id: category_id if category_id.present?}
  scope :learned, ->user{where("id IN (
    SELECT word_id FROM results WHERE lesson_id IN ( SELECT id FROM lessons WHERE user_id = ?
      ))",user.id)}
  scope :not_learned, ->user{where("id NOT IN (
    SELECT word_id FROM results WHERE lesson_id IN ( SELECT id FROM lessons WHERE user_id = ?
      ))",user.id)}
  scope :get_all, ->name{where("id IN(
    SELECT id FROM words)")}
  scope :alphabet, ->name{where("id IN(
    SELECT id FROM words)").order("name")}
end
