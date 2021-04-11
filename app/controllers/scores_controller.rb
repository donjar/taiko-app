class ScoresController < ApplicationController
  def list
    @scores = Score.all.order(score: :desc).includes(:chart, chart: [:song])
  end
end
