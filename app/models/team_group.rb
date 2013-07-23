class TeamGroup < ActiveRecord::Base
  attr_accessible :group_id, :team_id, :tournament_id

  belongs_to :tournament
  belongs_to :team 
  belongs_to :group
end
