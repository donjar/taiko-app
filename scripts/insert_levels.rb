# frozen_string_literal: true

x = Nokogiri::HTML(File.read('/Users/donjar/hack/taiko/songlist.html'))
to_check = []

x.css('table')[3].css('tr').each do |row|
  cells = row.css('td')
  next if cells.length < 9 || cells[2].css('strong').nil?

  name = cells[2].css('strong').text
  bpm = cells[3].text
  # kantan = cells[4].text[2..]
  # fuutsu = cells[5].text[2..]
  # muzu = cells[6].text[2..]
  oni = cells[7].text[2..]
  ura = cells[8].text[2..]

  song = Song.find_by(name: name)
  if song.nil?
    to_check.push(name)
    next
  end

  song.update(bpm: bpm)
  Chart.find_by(song: song, level: 'Oni').update(stars: oni)
  next if ura.nil?

  c = Chart.find_by(song: song, level: 'Ura Oni')
  if c.nil?
    to_check.push(name)
    next
  end
  c.update(stars: ura)
end

p to_check
