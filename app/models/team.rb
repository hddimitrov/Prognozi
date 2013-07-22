class Team < ActiveRecord::Base
  attr_accessible :name, :national_team, :sport_id

  has_many :tournament_teams
  belongs_to :sport
end
