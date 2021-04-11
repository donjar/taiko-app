# frozen_string_literal: true

class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :score
      t.integer :ryo
      t.integer :ka
      t.integer :fuka
      t.integer :rolls
      t.references :chart, null: false, foreign_key: true

      t.timestamps
    end
  end
end
