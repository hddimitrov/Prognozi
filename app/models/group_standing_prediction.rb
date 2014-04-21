class GroupStandingPrediction < ActiveRecord::Base
  attr_accessible :user_id, :position, :group_id, :team_id

  belongs_to :user
  belongs_to :group
  belongs_to :team

  has_many :prediction_points, as: :prediction
end
