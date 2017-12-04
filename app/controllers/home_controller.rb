class HomeController < ApplicationController
  before_action :set_opponents, only: [:log, :log_create]
  

  def index
    @users = User.all.order(:rating).reverse
  end

  def history
    @matches = current_user.matches
  end

  def log
    @match = Match.new
    @match.scores.build(user: current_user, points:0)
    @match.scores.build(points:0)
    
  end

  def log_create
    @match = current_user.matches.new(params_match)
    if @match.save
      flash[:notice] = "Log game successfully created"
      redirect_to history_path
    else
      render 'log'
    end
  end

  private
    def params_match
      params.require(:match).permit(:played_at, scores_attributes: [:user_id, :points] )
    end

    def set_match
      @match = Match.find(params[:id]) rescue nil
    end

    def set_opponents
      @opponents = User.not_me(current_user.id)
    end
end
