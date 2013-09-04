class AddColumnToTeamGroups < ActiveRecord::Migration
  def change
    add_column :team_groups, :standing, :integer
  end
end
