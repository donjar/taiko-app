# frozen_string_literal: true

require 'csv'

s = ''

songs = s.parse_csv
songs.each do |song|
  song_model = Song.find_by(donder_hiroba_id: song)
  next if Chart.exists?(song: song_model)

  Chart.create(song: song_model, level: 'Ura Oni')
end
