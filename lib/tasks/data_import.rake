require 'csv'
namespace :import do
  desc 'Import group Maches'
  task group_matches: :environment do
    puts 'Importing group matches...'
    CSV.foreach('db/data/2014_world_cup_group_matches.csv', headers: :first_row, :col_sep => ';') do |row|
      match =  Match.find_or_initialize_by_code(row['code'].to_i)
      match.start_at = DateTime.parse(row['start_at'])
      match.location = row['location']
      match.phase_type = 'Group'
      match.phase_id = Group.find_by_name(row['group']).id
      opponents = row['opponents'].split('-')
      match.host_id = Team.find_by_name(opponents[0]).id
      match.guest_id = Team.find_by_name(opponents[1]).id
      match.save
    end
  end
  desc 'Import group Maches'
  task elimination_matches: :environment do
    puts 'Importing elimination matches...'
    CSV.foreach('db/data/2014_world_cup_elimination_matches.csv', headers: :first_row, :col_sep => ';') do |row|
      match =  Match.find_or_initialize_by_code(row['code'].to_i)
      match.start_at = DateTime.parse(row['start_at'])
      match.location = row['location']
      match.phase_type = 'Elimination'
      match.phase_id = Elimination.find_by_code(row['phase']).id
      match.save
    end
  end

  task group_standings: :environment do
    puts 'Importing group standings...'
    CSV.foreach('db/data/2014_world_cup_group_standings.csv', headers: :first_row, :col_sep => ';') do |row|
      group = Group.find_by_name(row['group'])
      team = Team.find_by_name(row['team'])
      standing =  GroupStanding.find_or_initialize_by_group_id_and_team_id(group.id, team.id)
      standing.position = 0 # row['position']
      standing.matches_played = row['matches_played']
      standing.matches_won = row['matches_won']
      standing.matches_drawn = row['matches_drawn']
      standing.matches_lost = row['matches_lost']
      standing.goals_for = row['goals_for']
      standing.goals_against = row['goals_against']
      standing.points = row['points']
      standing.save
    end
  end
end
