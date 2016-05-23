class ParticipantsController < ApplicationController
  before_filter :authenticate_user!, only: [:ranking]

  def ranking
    @active_participants = User.where(q_active: 1).order('group_phase_points + elimination_phase_points DESC, elimination_phase_points DESC, id ASC')
    # @inactive_participants = User.where(q_active: 0).order('id ASC')
    @inactive_participants = []
  end

  def rules
  end

  def scoring
  end
end

