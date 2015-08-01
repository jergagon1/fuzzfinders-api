class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  #TODO: what is the difference between as_json and to_json?
  def as_json options={}
    attributes.merge({comment_user_email: user.email}).as_json
  end

  def to_json
    as_json
  end
end
