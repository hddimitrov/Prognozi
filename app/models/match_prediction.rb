class MatchPrediction < ActiveRecord::Base
  attr_accessible :guest_score, :host_score, :match_id, :sign, :user_id

  belongs_to :user
  belongs_to :match
  has_one :prediction_points, as: :prediction

  after_save :calculate_sign

  private
    def calculate_sign
      if guest_score_changed? or host_score_changed?
        if self.host_score.present? and self.guest_score.present?
          ssign = 'X'
          if  host_score > guest_score
            ssign = '1'
          elsif host_score < guest_score
            ssign = '2'
          end
          self.update_column(:sign, ssign)
        end
      end
    end
end
