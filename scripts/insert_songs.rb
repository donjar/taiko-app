# frozen_string_literal: true

require 'csv'

s = ''

songs = CSV.parse(s)
songs.each do |song|
  next if Song.exists?(donder_hiroba_id: song[1])

  Song.create(name: song[0], donder_hiroba_id: song[1])
end
