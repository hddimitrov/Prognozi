class AddTournamentIdToTopScorerPredictions < ActiveRecord::Migration
  def change
    add_column :top_scorer_predictions, :tournament_id, :integer
    add_column :teams, :tournament_id, :integer
  end
end
