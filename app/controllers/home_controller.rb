class HomeController < ApplicationController
  def index
  end

  def history
  end

  def log
    @match = Match.new
    @match.scores.build(user: current_user, points:0)
    @match.scores.build(points:0)
    @opponents = User.not_me(current_user.id)
  end

  def log_create
    
  end
end
