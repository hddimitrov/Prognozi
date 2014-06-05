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
  has_one :top_scorer_prediction, dependent: :delete

  has_many :prediction_points, dependent: :delete_all

  def nick
    if name.present?
      names_no_butterflies = name.gsub(/[^[:alpha:] .-]+/, '').split(' ')
    end

    nick = String.new
    if name.blank?
      nick = 'User'
    else
      names_no_butterflies = name.gsub(/[^[:alpha:] .-]+/, '').split(' ')

      if names_no_butterflies.length > 1
        nick = names_no_butterflies.first + ' ' + names_no_butterflies.last[0].capitalize + '.'
      else
        nick = names_no_butterflies.first
      end
    end

    nick
  end

  def group_stage_ready?
    return self.match_predictions.where('host_score IS NOT NULL').where('guest_score IS NOT NULL').count == 48
  end

  def eliminations_ready?
    return self.elimination_predictions.count == 31
  end

  def top_scorer_ready?
    return self.top_scorer_prediction.present?
  end

end
