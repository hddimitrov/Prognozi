class GroupStanding < ActiveRecord::Base
  attr_accessible :group_id, :team_id, :position, :points, :goals_for, :goals_against, :played_matches

  attr_accessor :goal_difference

  belongs_to :group
  belongs_to :team

  def goal_difference
    goals_for.to_i - goals_against.to_i
  end
end
