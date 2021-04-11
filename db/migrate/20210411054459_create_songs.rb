# frozen_string_literal: true

class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :donder_hiroba_id

      t.timestamps
    end
  end
end
