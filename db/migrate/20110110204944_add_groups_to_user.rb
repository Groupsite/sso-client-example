class AddGroupsToUser < ActiveRecord::Migration
  def self.up
    add_column "users", "groups", :string
  end

  def self.down
    remove_column "users", "groups"
  end
end
