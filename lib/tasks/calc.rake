require 'csv'
namespace :calc do
  task ef: :environment do
    puts 'Importing Last 16 predictions'
    CSV.foreach('db/data/2016_euro_player_ef.csv', headers: :first_row, :col_sep => ',') do |row|
      user = User.find_by(name: row['name'])
      ef = Elimination.find_by(code: 'ef', tournament_id: $current_tournament).id
      pred = []
      pred << row['t1']
      pred << row['t2']
      pred << row['t3']
      pred << row['t4']
      pred << row['t5']
      pred << row['t6']
      pred << row['t7']
      pred << row['t8']
      pred << row['t9']
      pred << row['t10']
      pred << row['t11']
      pred << row['t12']
      pred << row['t13']
      pred << row['t14']
      pred << row['t15']
      pred << row['t16']
      pred.each do |t|
        team = Team.find_by(name: t)
        user.elimination_predictions.create(team_id: team.id, elimination_id: ef)
      end
    end
  end

  task gs: :environment do
    puts 'Importing group standings predictions'
    CSV.foreach('db/data/2016_euro_player_gs.csv', headers: :first_row, :col_sep => ',') do |row|
      user = User.find_by(name: row['name'])
      group = Group.find_by(name: row['group'], tournament_id: $current_tournament).id
      pos = row['pos'].to_i
      team = Team.find_by(name: row['team']).id
      user.group_standing_predictions.create(team_id: team, group_id: group, position: pos)
    end
  end

  task bonuses: :environment do
    User.all.find_each do |user|
      Group.all.find_each do |group|
        pts = PredictionPoint.joins("LEFT OUTER JOIN group_standing_predictions on prediction_type = 'GroupStandingPrediction' and prediction_id = group_standing_predictions.id")
        .where(user_id: user.id)
        .where("group_standing_predictions.group_id = #{group.id}").sum(:points)

        if pts.to_i == 8
          PredictionPoint.create(user_id: user.id, prediction_type: 'Group', prediction_id: group.id, points: $point_rules.gs_all_bonus)
        end
      end
    end
  end
end
