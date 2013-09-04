class CreateStandingPredictions < ActiveRecord::Migration
  def change
    create_table :standing_predictions do |t|
      t.integer :user_id
      t.integer :team_group_id
      t.integer :position
      t.integer :points

      t.timestamps
    end
  end
end
