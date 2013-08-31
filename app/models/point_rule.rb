class PointRule < ActiveRecord::Base
  attr_accessible :exact_result, :finalist_points, :group_winner_points, :quarter_finalist_points, :result_points, :room_id, :semi_finalist_points, :winner

  belongs_to :room
end
