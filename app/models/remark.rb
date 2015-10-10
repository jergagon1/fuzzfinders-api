class Remark < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :content, presence: true

  #TODO: look at replacing overwriting as_json with Active Model Serializers
  def as_json options={}
    attributes.merge({remark_username: user.username}).as_json
  end
end