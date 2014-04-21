class MatchPrediction < ActiveRecord::Base
  attr_accessible :guest_score, :host_score, :match_id, :sign, :user_id

  belongs_to :user
  belongs_to :match
  has_many :prediction_points, as: :prediction
end
