class ScorePrediction < ActiveRecord::Base
  attr_accessible :guest_score, :host_score, :match_id, :points, :result, :user_id

  
  belongs_to :user 
  belongs_to :match
  has_many :score_prediction_room_points
end
