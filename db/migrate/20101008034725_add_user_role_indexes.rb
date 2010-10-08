class AddUserRoleIndexes < ActiveRecord::Migration
  def self.up
    add_index :roles_users, :user_id, :unique => true
    add_index :roles_users, :role_id, :unique => true
  end

  def self.down
    remove_index :roles_users, :user_id
    remove_index :roles_users, :role_id
  end
end
