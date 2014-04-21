class CreateGroupStandingPredictions < ActiveRecord::Migration
  def change
    create_table :group_standing_predictions do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :team_id
      t.integer :position

      t.timestamps
    end

    add_index :group_standing_predictions, :user_id
    add_index :group_standing_predictions, [:user_id, :group_id]
    add_index :group_standing_predictions, [:user_id, :group_id, :team_id], unique: true, name: 'index_group_standings_predictions_uniq'
  end
end
