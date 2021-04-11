require 'csv'

s = ""

songs = CSV.parse(s)
songs.each do |s|
  next if Song.exists?(donder_hiroba_id: s[1])
  Song.create(name: s[0], donder_hiroba_id: s[1])
end
