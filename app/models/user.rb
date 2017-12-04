class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable
  has_many :scores
  has_many :matches, through: :scores
  
  scope :me, ->(user_id) { where(id: user_id) }  
  scope :not_me, ->(user_id) { where.not(id: user_id) }
end
