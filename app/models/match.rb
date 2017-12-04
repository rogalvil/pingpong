class Match < ActiveRecord::Base
  has_many :scores, dependent: :destroy
  has_many :users, :through => :scores

  accepts_nested_attributes_for :scores

  validates :played_at, presence: true
  validate :scores_limit_valid
  validate :scores_over_twenty_one_valid
  validate :scores_diference_two_points_valid

  def me(user_id)
    users.me(user_id).first
  end
  
  def oponent(user_id)
    users.not_me(user_id).first
  end

  def score_me(user_id)
    scores.me(user_id).first
  end
  
  def score_oponent(user_id)
    scores.not_me(user_id).first
  end

  def score(user_id)
    if won(user_id)
      "#{score_me(user_id).points}-#{score_oponent(user_id).points}"
    else
      "#{score_oponent(user_id).points}-#{score_me(user_id).points}"
    end
  end

  def won(user_id)
    (score_me(user_id).points > score_oponent(user_id).points)
  end

  def played_date
    played_at.strftime("%b %m")
  end

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
