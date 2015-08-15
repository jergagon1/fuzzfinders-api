class Article < ActiveRecord::Base
  belongs_to :user
  has_many :remarks
  has_many :article_tags
  has_many :tags, through: :article_tags

  # article tagging getter, setter
  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    # self.tags.map(&:name).join(", ")
    self.tags
  end
end
