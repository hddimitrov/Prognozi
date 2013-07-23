class Tournament < ActiveRecord::Base
  attr_accessible :name, :sport_id

  has_many :user_rooms 
  has_many :tournament_teams
  belongs_to :sport
end
