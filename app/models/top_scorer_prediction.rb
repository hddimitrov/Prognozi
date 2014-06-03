class TopScorerPrediction < ActiveRecord::Base
  attr_accessible :name, :user_id

  belongs_to :user
  has_one :prediction_points, as: :prediction
end
