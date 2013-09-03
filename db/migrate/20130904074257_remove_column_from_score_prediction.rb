class RemoveColumnFromScorePrediction < ActiveRecord::Migration
  def up
  	remove_column :score_predictions, :points
  	remove_column :user_rooms, :uid
  end

  def down
  	add_column :user_rooms, :uid, :integer
  	add_column :score_predictions, :points, :integer
  end
end
