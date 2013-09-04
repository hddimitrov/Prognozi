class CreateTeamPhases < ActiveRecord::Migration
  def change
    create_table :team_phases do |t|
      t.integer :team_id
      t.integer :phase_id
      t.integer :tournament_id

      t.timestamps
    end
  end
end
