class ChangeColumns < ActiveRecord::Migration[6.1]
  def change
    change_column :categories, :name, :string, null: false
    add_index :categories, :name, unique: true

    change_column :charts, :level, :string, null: false
    add_index :charts, [:song_id, :level], unique: true

    change_column :scores, :score, :integer, null: false
    change_column :scores, :ryo, :integer, null: false
    change_column :scores, :ka, :integer, null: false
    change_column :scores, :fuka, :integer, null: false
    change_column :scores, :rolls, :integer, null: false
    remove_index :scores, :chart_id
    add_index :scores, :chart_id, unique: true

    change_column :songs, :name, :string, null: false
    add_index :songs, :donder_hiroba_id, unique: true
  end
end
