class TournamentTeam < ActiveRecord::Base
  attr_accessible :team_id, :tournament_id

  belongs_to :tournament, :team
end
