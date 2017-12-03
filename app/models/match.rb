class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :users, :through => :scores
end
