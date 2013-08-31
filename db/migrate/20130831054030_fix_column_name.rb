class FixColumnName < ActiveRecord::Migration
  def change
  	rename_column :point_rules, :final_points, :finalist_points
  end
end
