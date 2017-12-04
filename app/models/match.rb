class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :users, :through => :scores

  accepts_nested_attributes_for :scores

  validates :played_at, presence: true
  validate :scores_limit_valid
  validate :scores_over_twenty_one_valid
  validate :scores_diference_two_points_valid

  private 
    def scores_limit_valid
      unless scores.length == 2
        errors.add(:scores, "they must be only 2")
      end
    end

    def scores_over_twenty_one_valid
      unless scores.map { |s| s.points if s.points >= 21 }.compact.any?
        errors.add(:scores, "at least some must be greater than 21")
      end
    end

    def scores_diference_two_points_valid
      points = scores.map(&:points).sort.reverse
      unless (points.first - points.last) >= 2
        errors.add(:scores, "must be at least 2 points")
      end
    end
end
