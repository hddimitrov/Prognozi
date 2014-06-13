class AddActiveFlagToUsers < ActiveRecord::Migration
  def change
    add_column :users, :q_active, :boolean, default: 1
  end
end
