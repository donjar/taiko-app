# frozen_string_literal: true

class ScoresController < ApplicationController
  def list_cards
    @scores = Score.joins(chart: { song: :song_categories })
    @scores = @scores.where('charts.stars' => params[:stars].map(&:to_i)) unless params[:stars].nil?
    unless params[:crown].nil?
      @scores = @scores.where('crown' => params[:crown].map do |c|
                                           Score::CROWN_MAPPING[c]
                                         end)
    end
    unless params[:bestScore].nil?
      @scores = @scores.where('best_score' => params[:bestScore].map do |c|
                                                Score::BEST_SCORE_MAPPING[c]
                                              end)
    end
    unless params[:sort].nil?
      @scores = @scores.order({
        'Score' => 'score',
        'Stars' => 'charts.stars',
        'Ryo' => 'ryo',
        'Ka' => 'ka',
        'Fuka' => 'fuka',
        'Penalty' => Arel.sql('ka + 2 * fuka'),
        'Song' => ['song_categories.category_id', 'song_categories.sequence_no'],
        'ScoreDesc' => 'score DESC',
        'StarsDesc' => 'charts.stars DESC',
        'RyoDesc' => 'ryo DESC',
        'KaDesc' => 'ka DESC',
        'FukaDesc' => 'fuka DESC',
        'PenaltyDesc' => Arel.sql('ka + 2 * fuka DESC')
      }[params[:sort]])
    end
    @scores = @scores.includes(chart: { song: { song_categories: :category } })
  end
end
