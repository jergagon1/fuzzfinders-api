class Article < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  validates :user_id, presence: true
end