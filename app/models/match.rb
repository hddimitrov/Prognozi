class Match < ActiveRecord::Base
  attr_accessible :guest_id, :guest_score, :host_id, :host_score, :result,
                  :start_at, :phase_type, :phase_id

  attr_accessor :name

  belongs_to :host, class_name: 'Team'
  belongs_to :guest, class_name: 'Team'
  belongs_to :phase, polymorphic: true

  has_many :match_predictions

  after_update :calculate_room_points, :if => :guest_score_changed? or :host_score_changed?

  def name
    name = host.name + "-" + guest.name
  end

  def sign
  	sign = 'x'
  	if self.guest_score > self.host_score
  	  sign = '2'
  	elsif self.guest_score < self.host_score
  	  sign = '1'
  	end

  	sign
  end

  private
    def calculate_room_points
      self.score_predictions.each do |prediction|
        prediction.user.user_rooms.each do |user_room|
          points = 0
          rules = PointRule.find_by_room_id(user_room.room_id)

          #Check for exact result predicition
          if(self.host_score == prediction.host_score and self.guest_score == prediction.guest_score)
            points += rules.exact_result
            # prediction.points += rules.exact_result
          end

          #Check for sign prediction
          if(self.sign == prediction.result)
            points += rules.result_points
          end

          sprp = ScorePredictionRoomPoint.find_or_initialize_by_room_id_and_score_prediction_id(user_room.room_id, prediction.id)
          sprp.points = points
          sprp.save
        end
      end
    end
end
