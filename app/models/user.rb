class User < ActiveRecord::Base
  before_save :downcase_email

  has_many :words, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :lessons, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  validates :name, presence: true, length: {maximum: 50}
  validates :password, length: {minimum: 6}, allow_blank: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}

  mount_uploader :avatar, PictureUploader
  validate  :picture_size

  has_secure_password

  def slug
    name.downcase.gsub(" ", "-")
  end

  def to_param
    [id, slug].join("-")
  end

  private
  def downcase_email
    self.email = email.downcase
  end

  def picture_size
    errors.add(:avatar, t("Warning")) if avatar.size > 5.megabytes
  end
end
