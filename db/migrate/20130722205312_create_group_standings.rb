class CreateGroupStandings < ActiveRecord::Migration
  def change
    create_table :group_standings do |t|
      t.integer :group_id
      t.integer :team_id
      t.integer :position
      t.integer :points
      t.integer :goals_for
      t.integer :goals_against

      t.timestamps
    end

    add_index :group_standings, :group_id
    add_index :group_standings, [:group_id, :team_id], unique: true
  end
end
