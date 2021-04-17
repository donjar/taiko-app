# frozen_string_literal: true

class ScoresController < ApplicationController
  def list
    @scores = Score.all.includes(:chart, chart: [:song])
  end
end
