class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :users, :through => :scores

  accepts_nested_attributes_for :scores
end
