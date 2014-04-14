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
    add_index :group_standing_predictions, [:user_id, :group_id, :position], unique: true, name: 'grp_stndgs_prdctns_uniq'
  end
end
