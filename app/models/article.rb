class Article < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :remarks

end
