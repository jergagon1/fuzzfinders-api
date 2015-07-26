class Article < ActiveRecord::Base
  belongs_to :user
  has_many :remarks
  has_many :article_tags
  has_many :tags, through: :article_tags
end
