class TeamGroups < ActiveRecord::Base
  attr_accessible :group_id, :team_id, :tournament_id

  belongs_to :tournamen, :team, :group
end
