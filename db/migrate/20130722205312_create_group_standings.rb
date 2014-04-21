class CreateGroupStandings < ActiveRecord::Migration
  def change
    create_table :group_standings do |t|
      t.integer :group_id
      t.integer :team_id
      t.integer :position, default: 0
      t.integer :matches_played, default: 0
      t.integer :matches_won, default: 0
      t.integer :matches_drawn, default: 0
      t.integer :matches_lost, default: 0
      t.integer :goals_for, default: 0
      t.integer :goals_against, default: 0
      t.integer :points, default: 0

      t.timestamps
    end

    add_index :group_standings, :group_id
    add_index :group_standings, [:group_id, :team_id], unique: true
  end
end
