class UserAddFbusersAttributes < ActiveRecord::Migration
  def up
    add_column :users, :provider, :string 
    add_column :users, :uid, :string
    add_column :users, :oath_token, :string
    add_column :users, :oath_expires_at, :datetime
  end

  def down
  end
end
