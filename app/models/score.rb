class Score < ActiveRecord::Base
  belongs_to :user
  belongs_to :match

  scope :me, ->(user_id) { where(user_id: user_id) }  
  scope :not_me, ->(user_id) { where.not(user_id: user_id) }
end
