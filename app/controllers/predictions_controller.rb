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

  def load_knockout_stage
    teams = {winners: {}, runners_up: {}, eliminations: {qf:[], sf:[], f:[], c: nil}}
    current_user.group_standing_predictions
      .joins("INNER JOIN groups ON group_standing_predictions.group_id = groups.id")
      .joins("INNER JOIN teams ON group_standing_predictions.team_id = teams.id")
      .where('groups.tournament_id' => current_tournament.id)
      .select('groups.name group_name, teams.id team_id, teams.name team_name, position')
    .find_each do |sp|
      if sp.position == 1
        teams[:winners][sp.group_name] = {team_id: sp.team_id, team_name: sp.team_name}
      end
      if
        teams[:runners_up][sp.group_name] = {team_id: sp.team_id, team_name: sp.team_name}
      end
    end

    current_user.elimination_predictions.joins('INNER JOIN teams ON elimination_predictions.team_id = teams.id')
      .joins("INNER JOIN eliminations ON elimination_predictions.elimination_id = eliminations.id AND eliminations.code IN ('qf','sf','f','c')")
      .select("teams.id team_id, teams.name team_name, eliminations.code stage")
    .find_each do |ep|
      teams[:eliminations][:qf] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'qf'
      teams[:eliminations][:sf] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'sf'
      teams[:eliminations][:f] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'f'
      teams[:eliminations][:c] = {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'c'
    end

    render json: teams
  end

  def save_knockout_stage
    qfe = Elimination.find_by_code('qf').id
    sfe = Elimination.find_by_code('sf').id
    fe = Elimination.find_by_code('f').id
    ce = Elimination.find_by_code('c').id
    current_user.elimination_predictions.where(elimination_id: [qfe, sfe, fe, ce]).delete_all

    if params[:qf].present?
      qf = params[:qf].split(',')
      qf.each do |team_id|
        current_user.elimination_predictions.create(team_id: team_id, elimination_id: qfe)
      end
    end

    if params[:sf].present?
      sf = params[:sf].split(',')
      sf.each do |team_id|
        current_user.elimination_predictions.create(team_id: team_id, elimination_id: sfe)
      end
    end

    if params[:f].present?
      f = params[:f].split(',')
      f.each do |team_id|
        current_user.elimination_predictions.create(team_id: team_id, elimination_id: fe)
      end
    end

    if params[:c].present?
      current_user.elimination_predictions.create(team_id: params[:c], elimination_id: ce)
    end

    render nothing: true
  end
end
