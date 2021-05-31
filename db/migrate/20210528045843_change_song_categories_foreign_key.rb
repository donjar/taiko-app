# frozen_string_literal: true

class ChangeSongCategoriesForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_column :song_categories, :categories_id
    add_reference :song_categories, :category, null: false, index: true
    add_foreign_key :song_categories, :categories
  end
end
