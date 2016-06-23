class ResultsController < ApplicationController
  before_filter :authenticate_user!


  def index
    @user = User.find_by(token: params[:token]) || current_user
    @groups = {}
    all_groups = Group.all.to_a
    all_groups.each do |g|
      @groups[g.name] = {} if @groups[g.name].blank?
      @groups[g.name][:name] = g.name
      @groups[g.name][:bonus] = PredictionPoint.find_by(user_id: @user.id, prediction_type: 'Group', prediction_id: g.id).try(:points).to_i
    end
    Match.joins("LEFT OUTER join match_predictions on match_predictions.match_id = matches.id AND match_predictions.user_id = #{@user.id}")
          .joins("LEFT OUTER JOIN prediction_points ON prediction_points.prediction_type = 'MatchPrediction' and prediction_points.prediction_id = match_predictions.id and prediction_points.user_id = match_predictions.user_id")
          .joins('INNER JOIN teams AS hosts ON hosts.id = matches.host_id')
          .joins('INNER JOIN teams AS guests ON guests.id = matches.guest_id')
          .where(phase_type: 'Group')
          .select("prediction_points.points, matches.host_score host_result, hosts.flag host_flag, guests.flag guest_flag, matches.guest_score guest_result, match_predictions.host_score host_prediction, match_predictions.guest_score guest_prediction, hosts.name host_team, guests.name guest_team, matches.id, matches.start_at, matches.code, matches.phase_id")
          .order("matches.start_at")
          .to_a.group_by(&:phase_id)
    .each do |group_id, matches|
      group_name = all_groups.detect{ |x| x.id == group_id}.name
      @groups[group_name][:matches] = matches
    end

    # @groups.each do |group_name, matches|
    #   group_id = all_groups.detect{ |x| x.name == group_name}.id
    #   @groups[group_name][:standings] = GroupStanding.joins(:team).where('group_standings.group_id' => group_id)
    #                                     .joins("LEFT OUTER JOIN group_standing_predictions ON group_standing_predictions.group_id = group_standings.group_id AND group_standing_predictions.team_id = group_standings.team_id and group_standing_predictions.user_id = #{@user.id}")
    #                                     .joins("LEFT OUTER JOIN prediction_points ON prediction_points.prediction_type = 'GroupStandingPrediction' and prediction_points.prediction_id = group_standing_predictions.id and prediction_points.user_id = group_standing_predictions.user_id")
    #                                     .select("prediction_points.points player_points, group_standing_predictions.position predicted_position, teams.name, group_standings.*")
    #                                     .order("predicted_position")
    # end

    @eliminations = {ef: [], qf:[], sf: [], f:[], c:[]}

    @user.elimination_predictions.joins('INNER JOIN teams ON elimination_predictions.team_id = teams.id')
                    .joins("INNER JOIN eliminations ON elimination_predictions.elimination_id = eliminations.id")
                    .joins("LEFT OUTER JOIN prediction_points ON prediction_points.prediction_type = 'EliminationPrediction' and prediction_points.prediction_id = elimination_predictions.id and prediction_points.user_id = elimination_predictions.user_id")
                    .select("teams.id team_id, teams.name team_name, teams.flag team_flag, eliminations.code stage, prediction_points.points player_points")
    .each do |ep|
      @eliminations[:ef] << {team_flag: ep.team_flag, team_name: ep.team_name, player_points: ep.player_points} if ep.stage == 'ef'
      @eliminations[:qf] << {team_flag: ep.team_flag, team_name: ep.team_name, player_points: ep.player_points} if ep.stage == 'qf'
      @eliminations[:sf] << {team_flag: ep.team_flag, team_name: ep.team_name, player_points: ep.player_points} if ep.stage == 'sf'
      @eliminations[:f] << {team_flag: ep.team_flag, team_name: ep.team_name, player_points: ep.player_points} if ep.stage == 'f'
      @eliminations[:c] << {team_flag: ep.team_flag, team_name: ep.team_name, player_points: ep.player_points} if ep.stage == 'c'
    end
  end

  def load_group_stage
    all_groups = Group.all
    groups = {}
    Match.joins("LEFT OUTER join match_predictions on match_predictions.match_id = matches.id AND match_predictions.user_id = #{current_user.id}")
          .joins("LEFT OUTER JOIN prediction_points ON prediction_points.prediction_type = 'MatchPrediction' and prediction_points.prediction_id = matches.id and prediction_points.user_id = match_predictions.user_id")
          .joins('INNER JOIN teams AS hosts ON hosts.id = matches.host_id')
          .joins('INNER JOIN teams AS guests ON guests.id = matches.guest_id')
          .where(phase_type: 'Group')
          .select("prediction_points.points, matches.host_score host_result, matches.guest_score guest_result, match_predictions.host_score host_prediction, match_predictions.guest_score guest_prediction, hosts.name host_team, guests.name guest_team, matches.id, matches.start_at, matches.code, matches.phase_id")
          .to_a.group_by(&:phase_id)
    .each do |group_id, matches|
      group_name = all_groups.detect{ |x| x.id == group_id}.name
      groups[group_name] = {} if groups[group_name].blank?
      groups[group_name][:matches] = matches
    end

    groups.each do |group_name, matches|
      group_id = all_groups.detect{ |x| x.name == group_name}.id
      groups[group_name][:standings] = GroupStanding.joins(:team).where('group_standings.group_id' => group_id)
                                        .joins("LEFT OUTER JOIN group_standing_predictions ON group_standing_predictions.group_id = group_standings.group_id AND group_standing_predictions.team_id = group_standings.team_id and group_standing_predictions.user_id = #{current_user.id}")
                                        .joins("LEFT OUTER JOIN prediction_points ON prediction_points.prediction_type = 'GroupStandingPrediction' and prediction_points.prediction_id = group_standing_predictions.id and prediction_points.user_id = group_standing_predictions.user_id")
                                        .select("prediction_points.points, group_standing_predictions.position predicted_position, teams.name, group_standings.*")
    end

    render json: groups
  end
end
