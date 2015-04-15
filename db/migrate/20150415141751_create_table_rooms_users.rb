class CreateTableRoomsUsers < ActiveRecord::Migration
  def change
    create_table :rooms_users, :id => false do |t|
      t.references :user
      t.references :room
      t.timestamps
    end
  end
end
