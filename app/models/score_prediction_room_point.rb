class ScorePredictionRoomPoint < ActiveRecord::Base
  attr_accessible :points, :room_id, :score_prediction_id

  belongs_to :room
  belongs_to :score_prediction
end
