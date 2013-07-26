class ChangeFbUserToFbuser < ActiveRecord::Migration
  def up
    rename_table :fb_users, :fbusers
  end

  def down
  end
end
