class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :gender

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
