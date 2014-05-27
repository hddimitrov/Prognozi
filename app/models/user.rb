class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :user_rooms
  has_many :score_predictions
end
