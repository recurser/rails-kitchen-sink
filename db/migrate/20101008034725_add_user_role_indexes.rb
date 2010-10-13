class AddUserRoleIndexes < ActiveRecord::Migration
  def self.up
    add_index :roles_users, [:user_id, :role_id], :uniq => true
  end

  def self.down
    add_index :roles_users, [:user_id, :role_id]
  end
end
