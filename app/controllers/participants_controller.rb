class ParticipantsController < ApplicationController
  before_filter :authenticate_user!

  def ranking
    @participants = User.order('group_phase_points')
  end

  def rules
  end
end
