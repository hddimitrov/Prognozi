class ParticipantsController < ApplicationController
  before_filter :authenticate_user!, only: [:ranking]

  def ranking
    @participants = User.order('group_phase_points')
  end

  def rules
  end

  def scoring
  end
end
