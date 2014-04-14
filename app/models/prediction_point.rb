class PredictionPoint < ActiveRecord::Base
  attr_accessible :points, :prediction_id, :prediction_type, :room_id, :user_id

  belongs_to :user
  belongs_to :room
end
