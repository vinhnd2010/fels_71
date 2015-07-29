class Activity < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :target_id, presence: true
  validates :name, presence: true

  scope :action, ->user{where "user_id = ?", user.id}

  private
  def action_name
    name == Settings.activities.learned ? Lesson.find_by(id: target_id) : User.find_by(id: target_id)
  end
end
