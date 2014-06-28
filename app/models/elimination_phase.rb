class EliminationPhase < ActiveRecord::Base
  attr_accessible :elimination_id, :team_id, :opponent_id

  belongs_to :elimination
  belongs_to :team
  belongs_to :opponent, class_name: :Team

  after_create :calculate_prediction_points

  private
    def calculate_prediction_points
      elimination_code = self.elimination.code
      EliminationPrediction.where(team_id: self.team_id, elimination_id: self.elimination_id).each do |prediction|
        points = $point_rules.send("e_#{elimination_code}_points")

        pp = PredictionPoint.find_or_initialize_by_user_id_and_prediction_type_and_prediction_id(prediction.user_id, 'EliminationPrediction', prediction.id)
        pp.points = points
        pp.save
      end
    end
end
