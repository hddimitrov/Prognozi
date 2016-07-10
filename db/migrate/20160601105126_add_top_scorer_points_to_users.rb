class AddTopScorerPointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :top_scorer_points, :integer, default: 0
  end
end
