class PredictionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @groups = Group.where(tournament_id: current_tournament.id)
    @match_predictions = Match.includes(:host).includes(:guest)
                              .joins("LEFT OUTER JOIN match_predictions ON match_predictions.match_id = matches.id AND match_predictions.user_id = #{current_user.id}")
                              .where(phase_type: 'Group')
                              .select("match_predictions.host_score host_prediction, match_predictions.guest_score guest_prediction, match_predictions.sign sign_prediction, matches.*")
                              .to_a.group_by(&:phase_id)

    @group_standing_predictions = GroupStanding.joins(:group).includes(:team).where('groups.tournament_id' => current_tournament.id)
                                    .joins("LEFT OUTER JOIN group_standing_predictions ON group_standing_predictions.group_id = group_standings.group_id AND group_standing_predictions.team_id = group_standings.team_id and group_standing_predictions.user_id = #{current_user.id}")
                                    .select("group_standing_predictions.position pos_prediction, group_standings.*")
                                    .order('group_standings.position')
                                    .to_a.group_by(&:group_id)
  end

  def match
    if params[:prediction].present?
      params[:prediction].each do |match, prog|
        pred = MatchPrediction.find_or_create_by_match_id_and_user_id(match, current_user.id)
        pred.sign = prog[:sign] if prog[:sign].present?
        pred.host_score = prog[:host] if prog[:host].present?
        pred.guest_score = prog[:guest] if prog[:guest].present?
        pred.save
      end
    end
    render nothing: true
  end

  def group
    if params[:group_id].present?
      GroupStandingPrediction.where(group_id: params[:group_id], user_id: current_user.id).delete_all
      GroupStandingPrediction.create(group_id: params[:group_id], user_id: current_user.id, position: 1, team_id: params[:winner])
      GroupStandingPrediction.create(group_id: params[:group_id], user_id: current_user.id, position: 2, team_id: params[:runner_up])

      group_teams = GroupStanding.where(group_id: params[:group_id]).pluck(:team_id)
      ef = Elimination.find_by_code('ef')
      EliminationPrediction.where(user_id: current_user.id, elimination_id: ef.id, team_id: group_teams).delete_all
      EliminationPrediction.create(user_id: current_user.id, elimination_id: ef.id, team_id: params[:winner])
      EliminationPrediction.create(user_id: current_user.id, elimination_id: ef.id, team_id: params[:runner_up])
    end
    render nothing: true
  end
end
