class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :lockable, :trackable

  alias_attribute :password_digest, :encrypted_password
  # before_create :skip_confirmation_notification!

  # one-to-many associations
  has_many :articles, dependent: :destroy

  before_save { self.email = email.downcase }
  #validates :username, presence: true,
  # uniqueness: {case_sensitive: false },
  # length: {minimum: 3 , maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  has_secure_password

  before_create :set_username

  private

  def set_username
    self.username = self.email[/^[^@]+/]
  end
end
