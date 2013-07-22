class Tournament < ActiveRecord::Base
  attr_accessible :name, :sport_id

  has_many :user_rooms, :tournament_teams
  belongs_to :sport
end
