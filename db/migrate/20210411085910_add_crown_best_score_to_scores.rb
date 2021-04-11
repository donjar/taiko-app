class AddCrownBestScoreToScores < ActiveRecord::Migration[6.1]
  def change
    add_column :scores, :crown, :string
    add_column :scores, :best_score, :string
  end
end
