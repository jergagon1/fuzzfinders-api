class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  def to_json
    attributes.merge({comment_user_email: user.email}).to_json
  end
end
