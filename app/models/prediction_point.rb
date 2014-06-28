class PredictionPoint < ActiveRecord::Base
  attr_accessible :points, :prediction_id, :prediction_type, :user_id

  belongs_to :user
  belongs_to :room
  belongs_to :prediction, polymorphic: true

  after_save :update_points
  after_destroy :update_points

  def update_points
    user = User.find_by_id(self.user_id)
    if self.prediction_type == 'EliminationPrediction'
      user.update_column(:elimination_phase_points, PredictionPoint.where(prediction_type: 'EliminationPrediction').where(user_id: self.user_id).sum(:points))
    else
      user.update_column(:group_phase_points, PredictionPoint.where(prediction_type: ['GroupStandingPrediction', 'MatchPrediction']).where(user_id: self.user_id).sum(:points))
    end
  end
end
