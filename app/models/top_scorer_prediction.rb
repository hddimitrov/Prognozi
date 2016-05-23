class TopScorerPrediction < ActiveRecord::Base
  attr_accessible :name, :user_id, :tournament_id

  belongs_to :user
  belongs_to :tournament
  has_one :prediction_points, as: :prediction
end
