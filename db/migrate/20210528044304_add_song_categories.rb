# frozen_string_literal: true

class AddSongCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :song_categories do |t|
      t.references :song, null: false, foreign_key: true
      t.references :categories, null: false, foreign_key: true
      t.integer :sequence_no, null: false

      t.timestamps
    end
  end
end
