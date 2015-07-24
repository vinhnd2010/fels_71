class Lesson < ActiveRecord::Base
  include CreateActivity

  after_create :save_activity
  before_create :save_lesson

  belongs_to :user
  belongs_to :category

  has_many :words, through: :lesson_words
  has_many :lesson_words, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :words, allow_destroy: true

  validates :name, presence: true
  validates :description, presence: true

  private
  def save_activity
    create_activity user_id, id, Settings.activities.learned
  end

  def save_lesson
    @category = Category.find self.category_id
    self.words = @category.words.limit(5).order("RAND()")
  end
end
