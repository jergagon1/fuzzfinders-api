class Comment < ActiveRecord::Base
  belongs_to :report
  belongs_to :user

  def as_json(options={})
    attributes.merge({comment_username: user.username}).as_json
  end

end
