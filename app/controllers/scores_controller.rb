class ScoresController < ApplicationController
  def list
    @scores = Score.all.order(score: :desc).includes(:chart, chart: [:song])
    unless params["stars"].nil?
      @scores = @scores.where("charts.stars" => params["stars"])
    end
    if params["played"] == "true"
      @scores = @scores.where.not("scores.best_score" => nil)
    elsif params["played"] == "false"
      @scores = @scores.where("scores.best_score" => nil)
    end
  end
end
