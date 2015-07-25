class User < ActiveRecord::Base
  validates :username, :email, :password_hash, presence: true
  validates :username, :email, uniqueness: true
  has_many :reports


end
