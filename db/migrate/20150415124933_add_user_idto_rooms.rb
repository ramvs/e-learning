class AddUserIdtoRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :user_id , :integer
    add_column :users, :room_id , :integer
  end
end
