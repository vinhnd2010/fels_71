class Lesson < ActiveRecord::Base
  include CreateActivity

  after_create :save_activity
  after_create :init_result
  before_save :init_lesson_name

  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :results

  validate :check_words_left, on: :create

  def num_of_correct_ans
    self.results.select{|result| !result.answer.nil? && result.answer.correct}.length
  end

  def time_remaining
    Settings.lesson.duration_in_minutes * 60 - (Time.zone.now - self.created_at).to_i
  end

  private
  def init_lesson_name
    @lessons = Lesson.all
    self.name = I18n.t("lesson.lesson") + "#{@lessons.count}"
  end

  def save_activity
    create_activity user_id, id, Settings.activities.learned
  end

  def init_result
    self.category.words.not_learned(self.user).random_questions.each do |word|
      self.results.create word_id: word.id
    end
  end

  def check_words_left
    @words = self.category.words.not_learned(self.user).random_questions
    if @words.count < Settings.lesson.category_minimum_words
      errors.add :words, I18n.t("lesson.not_enough_word")
    end
  end
end
