class EliminationPrediction < ActiveRecord::Base
  attr_accessible :user_id, :elimination_id, :team_id

  belongs_to :user
  belongs_to :elimination
  belongs_to :team

  has_many :prediction_points, as: :prediction
end
