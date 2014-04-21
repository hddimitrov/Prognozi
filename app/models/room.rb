class Room < ActiveRecord::Base
  attr_accessible :name, :tournament_id, :creator_id, :q_public,
                  :m_score_points, :m_sign_points, :gs_position_1_points, :e_ef_points, :e_qf_points, :e_sf_points, :e_l_points, :e_f_points, :e_c_points

  belongs_to :tournament

  has_many :user_rooms
  has_many :users, through: :user_rooms
  has_many :prediction_points

  has_many :invitations
end
