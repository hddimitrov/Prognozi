class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.boolean :national_team
      t.integer :sport_id

      t.timestamps
    end
  end
end
