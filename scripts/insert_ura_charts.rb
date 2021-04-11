require 'csv'

s = ""

songs = s.parse_csv
songs.each do |s|
  song = Song.find_by(donder_hiroba_id: s)
  next if Chart.exists?(song: song)
  Chart.create(song: song, level: "Ura Oni")
end
