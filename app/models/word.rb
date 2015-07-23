class Word < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :lessons, through: :lesson_words
  has_many :lesson_words, dependent: :destroy

end
