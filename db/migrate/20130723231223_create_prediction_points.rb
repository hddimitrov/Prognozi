class CreatePredictionPoints < ActiveRecord::Migration
  def change
    create_table :prediction_points do |t|
      t.integer :user_id
      t.integer :room_id
      t.string :prediction_type
      t.integer :prediction_id
      t.float :points

      t.timestamps
    end
  end
end
