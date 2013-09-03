class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid, :oauth_token, :oauth_expires_at

  has_many :user_rooms
  has_many :score_predictions
  has_many :user_bets

  def room_points(room_id)
	points = 0
	rules = PointRule.find_by_room_id(room_id)

	self.score_predictions.each do |prediction|
		match = prediction.match
		sprp = ScorePredictionRoomPoint.find_or_initialize_by_room_id_and_score_prediction_id(room_id, prediction.id)

		#Check for exact result predicition
		if(match.host_score == prediction.host_score and match.guest_score == prediction.guest_score)
			points += rules.exact_result
			# prediction.points += rules.exact_result
		end

		#Check for sign prediction
		if(match.host_score > match.guest_score and prediction.result == 1)
			points += rules.result_points
			# prediction.points += rules.result_points
		elsif(match.host_score < match.guest_score and prediction.result == 2)
			points += rules.result_points
			# prediction.points += rules.result_points
		elsif(match.host_score == match.guest_score and prediction.result == "x")
			points += rules.result_points
			# prediction.points += rules.result_points
		end


		sprp.points = points
		sprp.save
	end
	return points
  end
end
