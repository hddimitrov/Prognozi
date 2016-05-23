class Team < ActiveRecord::Base
  attr_accessible :name, :flag, :tournament_id

  has_many :home_matches, foreign_key: :host_id, class_name: :Match
  has_many :away_matches, foreign_key: :guest_id, class_name: :Match
  has_many :elimination_phases, foreign_key: :team_id, class_name: :EliminationPhase
  has_many :elimination_opponents, foreign_key: :opponent_id, class_name: :EliminationPhase

  has_many :elimination_phase_predictions
  has_one :group_standing
  has_many :group_standing_predictions

  belongs_to :tournament
end
