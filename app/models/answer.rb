class Answer < ActiveRecord::Base
  belongs_to :word

  has_many :results, dependent: :destroy

  scope :correct, ->{where "correct = 1"}
end
