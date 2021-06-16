# frozen_string_literal: true

namespace :insert do
  desc 'Insert various things to the database'

  task :scores, [:donder_hiroba_token] => [:environment] do |_task, args|
    puts 'Have you refreshed your DH page?'

    levels = { 'Oni' => 4, 'Ura Oni' => 5 }

    Chart.find_each do |chart|
      puts "Processing #{chart.song.name} (#{chart.level})"
      resp = HTTParty.get(
        "https://donderhiroba.jp/score_detail.php?song_no=#{chart.song.donder_hiroba_id}&level=#{levels[chart.level]}",
        cookies: { '_token_v2' => args.donder_hiroba_token },
        headers: {
          'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0'
        }
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

      score_object = Score.find_by(chart: chart)
      if score_object.nil?
        puts "#{chart.song.name} (#{chart.level}) added (#{score})"
        Score.create(chart: chart, **params)
      else
        old_score = score_object.score
        score_object.update(params)
        puts "#{chart.song.name} (#{chart.level}) updated (#{old_score} -> #{score})" if old_score != score.to_i
      end
    end
  end

  task :charts, [:donder_hiroba_token] => [:environment] do |_task, args|
    genre_map = ['Pop', 'Anime', 'Kids', 'Vocaloid', 'Game Music', 'NAMCO Original', 'Variety', 'Classical']

    SongCategory.destroy_all

    1.upto(8).each do |genre|
      category = Category.find_or_create_by(name: genre_map[genre - 1])
      puts "Processing category: #{category.name}"

      resp = HTTParty.get(
        "https://donderhiroba.jp/score_list.php?genre=#{genre}",
        cookies: { '_token_v2' => args.donder_hiroba_token },
        headers: {
          'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:87.0) Gecko/20100101 Firefox/87.0'
        }
      )
      parsed = Nokogiri::HTML(resp.body)

      sequence_no = 0
      parsed.css('.contentBox').each do |content_box|
        song_name_area = content_box.children[1]
        button_area = content_box.children[3]

        title = song_name_area.text.strip
        button = button_area.children[1].children[1]
        ura = button.children.empty?
        oni_button = button_area.children[1].children[7]

        song_id = CGI.parse(URI(oni_button.css('a')[0].attribute('href').value).query)['song_no'][0]

        unless Song.exists?(donder_hiroba_id: song_id)
          puts "New song: #{title} (id: #{song_id})"
          Song.create(name: title, donder_hiroba_id: song_id)
        end

        song = Song.find_by(donder_hiroba_id: song_id)
        if SongCategory.find_by(song: song, category: category).nil?
          SongCategory.create(song: song, category: category, sequence_no: sequence_no)
        end
        sequence_no += 1 unless ura

        unless Chart.exists?(song: song, level: 'Oni')
          puts "New Oni chart: #{title}"
          Chart.create(song: song, level: 'Oni')
        end
        if ura && !Chart.exists?(song: song, level: 'Ura Oni')
          puts "New Ura Oni chart: #{title}"
          Chart.create(song: song, level: 'Ura Oni')
        end
      end
    end
  end
end
