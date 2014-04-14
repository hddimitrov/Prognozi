class CreateEliminationPredictions < ActiveRecord::Migration
  def change
    create_table :elimination_predictions do |t|
      t.integer :user_id
      t.integer :elimination_id
      t.integer :team_id
      t.timestamps
    end
    add_index :elimination_predictions, :user_id
    add_index :elimination_predictions, [:user_id, :elimination_id]
    add_index :elimination_predictions, [:user_id, :elimination_id, :team_id], unique: true, name: 'index_elimination_predictions_phase_team_uniq'
  end
end
