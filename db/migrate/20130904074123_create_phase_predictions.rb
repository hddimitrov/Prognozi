class CreatePhasePredictions < ActiveRecord::Migration
  def change
    create_table :phase_predictions do |t|
      t.integer :user_id
      t.integer :phase_id
      t.integer :team_id
      t.integer :points

      t.timestamps
    end
  end
end
