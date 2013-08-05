class UserRenameOauth < ActiveRecord::Migration
  def up
    rename_column :users , :oath_token, :oauth_token
    rename_column :users , :oath_expires_at, :oauth_expires_at

  end

  def down
  end
end
