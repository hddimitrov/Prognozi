class GroupStanding < ActiveRecord::Base
  attr_accessible :group_id, :team_id, :position, :points, :goals_for, :goals_against

  belongs_to :group
  belongs_to :team
end
