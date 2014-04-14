class CreateMatchPredictions < ActiveRecord::Migration
  def change
    create_table :match_predictions do |t|
      t.integer :user_id
      t.integer :match_id
      t.integer :host_score
      t.integer :guest_score
      t.string :result

      t.timestamps
    end
    add_index :match_predictions, :user_id
    add_index :match_predictions, [:user_id, :match_id], unique: true
  end
end
