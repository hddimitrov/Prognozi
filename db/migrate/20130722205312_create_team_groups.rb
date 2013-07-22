class CreateTeamGroups < ActiveRecord::Migration
  def change
    create_table :team_groups do |t|
      t.integer :tournament_id
      t.integer :team_id
      t.integer :group_id

      t.timestamps
    end
  end
end
