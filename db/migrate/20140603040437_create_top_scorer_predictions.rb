class CreateTopScorerPredictions < ActiveRecord::Migration
  def change
    create_table :top_scorer_predictions do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
    add_index :top_scorer_predictions, :user_id, :unique => true
  end
end
