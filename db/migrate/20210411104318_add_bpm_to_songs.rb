# frozen_string_literal: true

class AddBpmToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :bpm, :string
  end
end
