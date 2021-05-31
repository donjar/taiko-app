# frozen_string_literal: true

class Score < ApplicationRecord
  CROWN_MAPPING = { 'Unplayed' => nil,
                    'Failed' => 'https://donderhiroba.jp/image/sp/640/crown_large_0_640.png',
                    'Cleared' => 'https://donderhiroba.jp/image/sp/640/crown_large_1_640.png',
                    'FullCombo' => 'https://donderhiroba.jp/image/sp/640/crown_large_2_640.png',
                    'DonderFullCombo' => 'https://donderhiroba.jp/image/sp/640/crown_large_3_640.png' }.freeze
  BEST_SCORE_MAPPING = { 'NoBadge' => nil,
                         'WhiteBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_2_640.png',
                         'BronzeBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_3_640.png',
                         'SilverBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_4_640.png',
                         'GoldBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_5_640.png',
                         'PinkBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_6_640.png',
                         'PurpleBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_7_640.png',
                         'RainbowBadge' => 'https://donderhiroba.jp/image/sp/640/best_score_rank_8_640.png' }.freeze
  belongs_to :chart
end
