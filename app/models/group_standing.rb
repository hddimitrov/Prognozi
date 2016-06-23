class GroupStanding < ActiveRecord::Base
  attr_accessible :group_id, :team_id, :position, :points, :goals_for, :goals_against,
                  :matches_played, :matches_won, :matches_drawn, :matches_lost

  attr_accessor :goal_difference

  belongs_to :group
  belongs_to :team

  after_save :calculate_prediction_points

  def goal_difference
    goals_for.to_i - goals_against.to_i
  end

  private
    def calculate_prediction_points
      GroupStandingPrediction.where(group_id: self.group_id, position: self.position).each do |prediction|
        points = 0

        if(self.team_id == prediction.team_id and self.position == prediction.position)
          points = $point_rules.send("gs_position_#{prediction.position}_points")
        else
          points = 0
        end


        pp = PredictionPoint.find_or_initialize_by(user_id: prediction.user_id, prediction_type: 'GroupStandingPrediction', prediction_id: prediction.id)
        pp.points = points
        pp.save
      end
    end
end
