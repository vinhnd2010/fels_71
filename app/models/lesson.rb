class Lesson < ActiveRecord::Base
  include CreateActivity

  after_create :save_activity

  belongs_to :user
  belongs_to :category

  has_many :words, through: :lesson_words
  has_many :lesson_words, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true

  private
  def save_activity
    create_activity user_id, id, Settings.activities.learned
  end
end
