class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
          #:confirmable#, :omniauthable

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  # validates :authentication_token, presence: true, uniqueness: true

  has_many :reports
  has_many :comments
  has_many :articles
  has_many :remarks

  def update_coordinates!(latitude, longitude)
    self.latitude = latitude
    self.longitude = longitude

    save
  end
end
