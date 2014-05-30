class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation,
                  :name, :referer_name, :group_phase_points, :elimination_phase_points



  validates :name, :presence => true
  validates :referer_name, :presence => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :prediction_points, dependent: :delete_all
  has_many :match_predictions, dependent: :delete_all
  has_many :group_standing_predictions, dependent: :delete_all
  has_many :elimination_predictions, dependent: :delete_all

  has_many :prediction_points, dependent: :delete_all

end
