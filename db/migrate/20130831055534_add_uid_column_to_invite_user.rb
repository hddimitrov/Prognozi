class AddUidColumnToInviteUser < ActiveRecord::Migration
  def change
    add_column :invite_users, :uid, :string
  end
end
