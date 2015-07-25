class Article < ActiveRecord::Base
  has_many :remarks
  belongs_to :user
end
