class CreateScorePredictionRoomPoints < ActiveRecord::Migration
  def change
    create_table :score_prediction_room_points do |t|
      t.integer :score_prediction_id
      t.integer :room_id
      t.integer :points

      t.timestamps
    end
  end
end
