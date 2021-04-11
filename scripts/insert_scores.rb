# frozen_string_literal: true

require 'HTTParty'

levels = { 'Oni' => 4, 'Ura Oni' => 5 }
Chart.find_each do |chart|
  resp = HTTParty.get(
    "https://donderhiroba.jp/score_detail.php?song_no=#{chart.song.donder_hiroba_id}&level=#{levels[chart.level]}",
    cookies: { '_token_v2' => 'bph8ta1g1al4susvu3al3p8vn6' },
    headers: { 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0' }
  )
  parsed = Nokogiri::HTML(resp.body)

  score = parsed.css('.high_score > span')[0].text[0..-2]
  ryo = parsed.css('.good_cnt > span')[0].text[0..-2]
  ka = parsed.css('.ok_cnt > span')[0].text[0..-2]
  fuka = parsed.css('.ng_cnt > span')[0].text[0..-2]
  rolls = parsed.css('.pound_cnt > span')[0].text[0..-2]
  crown = parsed.css('.crown')[0]&.attribute('src')
  best_score = parsed.css('.best_score_icon')[0]&.attribute('src')
  params = { score: score, ryo: ryo, ka: ka, fuka: fuka, rolls: rolls,
             crown: crown.nil? ? nil : "https://donderhiroba.jp/#{crown}",
             best_score: best_score.nil? ? nil : "https://donderhiroba.jp/#{best_score}" }

  score = Score.find_by(chart: chart)
  if score.nil?
    Score.create(chart: chart, **params)
  else
    score.update(params)
  end
end
