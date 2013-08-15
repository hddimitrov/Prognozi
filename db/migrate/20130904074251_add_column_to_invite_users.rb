class AddColumnToInviteUsers < ActiveRecord::Migration
  def change
    add_column :invite_users, :status, :string
  end
end
