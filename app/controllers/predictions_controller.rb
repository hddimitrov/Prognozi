class PredictionsController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @groups = Group.where(tournament_id: current_tournament.id)
    @group_predictions = Match.includes(:host).includes(:guest)
                              .joins("LEFT OUTER JOIN match_predictions ON match_predictions.match_id = matches.id AND match_predictions.user_id = #{current_user.id}")
                              .where(phase_type: 'Group')
                              .select("match_predictions.host_score host_prediction, match_predictions.guest_score guest_prediction, match_predictions.sign sign_prediction, matches.*")
                              .to_a.group_by(&:phase_id)

    @group_standings = GroupStanding.joins(:group).includes(:team).where('groups.tournament_id' => current_tournament.id)
                                    .joins("LEFT OUTER JOIN group_standing_predictions ON group_standing_predictions.group_id = group_standings.id AND group_standing_predictions.team_id = group_standings.team_id and group_standing_predictions.user_id = #{current_user.id}")
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
end

# Rails server cmd log

# "prediction"=>
#   {
#     "1"=>{"host_result"=>"host1", "guest_result"=>"guest1", "sign_select"=>"1"},
#     "2"=>{"host_result"=>"host2", "guest_result"=>"guest2", "sign_select"=>"x"},
#     "3"=>{"host_result"=>"host3", "guest_result"=>"guest3", "sign_select"=>"2"}
#   },

# params[:prediction].each |k, v| do
#   score = ScorePrediction.new
#   score.user_id = current_user.id
#   score.match_id = k
#   score.host_sore = v[:host_result]
#   score.guest_result = v[:guest_result]
#   score.sign_select = v[:sign_select]
# end
