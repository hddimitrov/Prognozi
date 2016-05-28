class PredictionsController < ApplicationController
  before_filter :authenticate_user!, except: [:points]

  def dev
    @groups = Group.where(tournament_id: $current_tournament)
  end

  def index
    # redirect_to controller: :results, action: :index, token: current_user.token and return

    @groups = Group.where(tournament_id: $current_tournament)
  end

  def match
    if params[:prediction].present?
      params[:prediction].each do |match, prog|
        pred = MatchPrediction.find_or_initialize_by(match_id: match, user_id: current_user.id)
        pred.sign = prog[:sign] if prog[:sign].present?
        pred.host_score = prog[:host] if prog[:host].present?
        pred.guest_score = prog[:guest] if prog[:guest].present?
        pred.save
      end
    end
    render nothing: true
  end

  def group
    puts params[:prediction]
    if params[:prediction].present?
      params[:prediction].each do |group_code, standing|
        group_id = Group.find_by(name: group_code).id
        GroupStandingPrediction.where(group_id: group_id, user_id: current_user.id).delete_all
        group_teams = GroupStanding.where(group_id: group_id).pluck(:team_id)
        ef = Elimination.find_by_code('ef')
        EliminationPrediction.where(user_id: current_user.id, elimination_id: ef.id, team_id: group_teams).delete_all

        GroupStandingPrediction.create(group_id: group_id, user_id: current_user.id, position: 1, team_id: standing[:winner])
        GroupStandingPrediction.create(group_id: group_id, user_id: current_user.id, position: 2, team_id: standing[:runner_up])
        GroupStandingPrediction.create(group_id: group_id, user_id: current_user.id, position: 3, team_id: standing[:third])
        GroupStandingPrediction.create(group_id: group_id, user_id: current_user.id, position: 4, team_id: standing[:last])

        # EliminationPrediction.create(user_id: current_user.id, elimination_id: ef.id, team_id: standing[:winner])
        # EliminationPrediction.create(user_id: current_user.id, elimination_id: ef.id, team_id: standing[:runner_up])
      end
    end
    render nothing: true
  end

  def load_group_stage
    all_groups = Group.where(tournament_id: $current_tournament)
    groups = {}
    Match.group_games.joins("LEFT OUTER JOIN match_predictions ON match_predictions.match_id = matches.id AND match_predictions.user_id = #{current_user.id}")
          .joins('INNER JOIN teams AS hosts ON hosts.id = matches.host_id')
          .joins('INNER JOIN teams AS guests ON guests.id = matches.guest_id')
          .select("match_predictions.host_score host_prediction, match_predictions.guest_score guest_prediction, hosts.name host_team, hosts.flag host_flag, guests.name guest_team, guests.flag guest_flag, matches.id, matches.start_at, matches.code, matches.phase_id")
          .to_a.group_by(&:phase_id)
    .each do |group_id, matches|
      group_name = all_groups.detect{ |x| x.id == group_id}.name
      groups[group_name] = {} if groups[group_name].blank?
      groups[group_name][:matches] = matches
    end

    groups.each do |group_name, matches|
      group_id = all_groups.detect{ |x| x.name == group_name}.id
      groups[group_name][:teams] = Team.joins(:group_standing).where('group_standings.group_id' => group_id)
                                       .joins("LEFT OUTER JOIN group_standing_predictions ON group_standing_predictions.group_id = group_standings.group_id AND group_standing_predictions.team_id = group_standings.team_id and group_standing_predictions.user_id = #{current_user.id}")
                                       .select("group_standing_predictions.position predicted_position, teams.*")
    end

    render json: groups
  end

  def load_knockout_stage
    teams = {qf:[], sf:[], f:[], c: []}
    # current_user.group_standing_predictions
    #   .joins("INNER JOIN groups ON group_standing_predictions.group_id = groups.id")
    #   .joins("INNER JOIN teams ON group_standing_predictions.team_id = teams.id")
    #   .where('groups.tournament_id' => current_tournament.id)
    #   .select('groups.name group_name, teams.id team_id, teams.name team_name, position')
    # .each do |sp|
    #   if sp.position == 1 and
    #     teams[:last_16][:winners][sp.group_name] = {team_id: sp.team_id, team_name: sp.team_name}
    #   end
    #   if sp.position == 2
    #     teams[:last_16][:runners_up][sp.group_name] = {team_id: sp.team_id, team_name: sp.team_name}
    #   end
    # end

    current_user.elimination_predictions
      .joins('INNER JOIN teams ON elimination_predictions.team_id = teams.id')
      .joins("INNER JOIN eliminations ON elimination_predictions.elimination_id = eliminations.id AND eliminations.code IN ('qf','sf','f','c') AND eliminations.tournament_id = #{$current_tournament}")
      .select("teams.id team_id, teams.name team_name, eliminations.code stage")
    .each do |ep|
      teams[:qf] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'qf'
      teams[:sf] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'sf'
      teams[:f] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'f'
      teams[:c] << {team_id: ep.team_id, team_name: ep.team_name} if ep.stage == 'c'
    end

    render json: teams
  end

  def save_knockout_stage
    qfe = Elimination.find_by(code: 'qf', tournament_id: $current_tournament).id
    sfe = Elimination.find_by(code: 'sf', tournament_id: $current_tournament).id
    fe = Elimination.find_by(code: 'f', tournament_id: $current_tournament).id
    ce = Elimination.find_by(code: 'c', tournament_id: $current_tournament).id
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

  def top_scorer
    if params[:name].present?
      top_scorer_prediction = TopScorerPrediction.find_or_initialize_by(user_id: current_user.id, tournament_id: $current_tournament)
      top_scorer_prediction.name = params[:name]
      top_scorer_prediction.save
    end
    render nothing: true
  end
end
