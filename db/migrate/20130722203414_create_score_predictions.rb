class CreateScorePredictions < ActiveRecord::Migration
  def change
    create_table :score_predictions do |t|
      t.integer :user_id
      t.integer :match_id
      t.integer :host_score
      t.integer :guest_score
      t.string :result
      t.integer :points

      t.timestamps
    end
  end
end
