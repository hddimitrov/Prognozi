class AddCoefToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :coef, :integer
  end
end
