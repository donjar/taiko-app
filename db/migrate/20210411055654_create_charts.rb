class CreateCharts < ActiveRecord::Migration[6.1]
  def change
    create_table :charts do |t|
      t.references :song, null: false, foreign_key: true
      t.string :level
      t.integer :stars

      t.timestamps
    end
  end
end
