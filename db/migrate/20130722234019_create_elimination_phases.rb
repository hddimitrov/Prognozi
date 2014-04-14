class CreateEliminationPhases < ActiveRecord::Migration
  def change
    create_table :elimination_phases do |t|
      t.integer :elimination_id
      t.integer :team_id
      t.integer :opponent_id

      t.timestamps
    end
    add_index :elimination_phases, :elimination_id
    add_index :elimination_phases, [:elimination_id, :team_id], unique: true, name: 'index_eliminations_phase_team_uniq'
  end
end
