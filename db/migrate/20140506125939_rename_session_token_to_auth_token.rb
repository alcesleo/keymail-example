class RenameSessionTokenToAuthToken < ActiveRecord::Migration
  def change
    rename_column :users, :session_token, :auth_token
  end
end
