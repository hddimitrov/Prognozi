class DeleteFbusersBetsUserbets < ActiveRecord::Migration
  def up
    drop_table :fbusers
    drop_table :bets
    drop_table :user_bets
  end

  def down
  end
end
