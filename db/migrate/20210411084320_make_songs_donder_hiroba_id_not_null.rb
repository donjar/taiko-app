# frozen_string_literal: true

class MakeSongsDonderHirobaIdNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column :songs, :donder_hiroba_id, :integer, null: false
  end
end
