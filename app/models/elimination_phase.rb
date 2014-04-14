class EliminationPhase < ActiveRecord::Base
  attr_accessible :elimination_id, :team_id, :opponent_id

  belongs_to :elimination
  belongs_to :team
  belongs_to :opponent, class_name: 'Team'
end
