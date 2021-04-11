# frozen_string_literal: true

class ScoresController < ApplicationController
  def list
    @scores = Score.all.order(score: :desc).includes(:chart, chart: [:song])
    @scores = @scores.where('charts.stars' => params['stars']) unless params['stars'].nil?
    case params['played']
    when 'true'
      @scores = @scores.where.not('scores.best_score' => nil)
    when 'false'
      @scores = @scores.where('scores.best_score' => nil)
    end
  end
end
