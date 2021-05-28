# frozen_string_literal: true

class ScoresController < ApplicationController
  def list
    @scores = Score.all.includes(:chart, chart: [:song])
  end

  def list_cards
    @scores = Score.all
    @scores = @scores.where('charts.stars' => params[:stars].map(&:to_i)) unless params[:stars].nil?
    unless params[:crown].nil?
      @scores = @scores.where('crown' => params[:crown].map do |c|
                                           { 'Unplayed' => nil,
                                             'Failed' => 'https://donderhiroba.jp/image/sp/640/crown_large_0_640.png',
                                             'Cleared' => 'https://donderhiroba.jp/image/sp/640/crown_large_1_640.png',
                                             'FullCombo' => 'https://donderhiroba.jp/image/sp/640/crown_large_2_640.png',
                                             'DonderFullCombo' => 'https://donderhiroba.jp/image/sp/640/crown_large_3_640.png' }[c]
                                         end)
    end
    unless params[:bestScore].nil?
      @scores = @scores.where('best_score' => params[:bestScore].map do |c|
                                                { 'NoBadge' => nil,
                                                  'WhiteBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_2_640.png',
                                                  'BronzeBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_3_640.png',
                                                  'SilverBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_4_640.png',
                                                  'GoldBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_5_640.png',
                                                  'PinkBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_6_640.png',
                                                  'PurpleBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_7_640.png',
                                                  'RainbowBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_8_640.png' }[c]
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
        'ScoreDesc' => 'score DESC',
        'StarsDesc' => 'charts.stars DESC',
        'RyoDesc' => 'ryo DESC',
        'KaDesc' => 'ka DESC',
        'FukaDesc' => 'fuka DESC',
        'PenaltyDesc' => Arel.sql('ka + 2 * fuka DESC')
      }[params[:sort]])
    end
    @scores = @scores.includes(:chart, chart: [:song])
  end
end
