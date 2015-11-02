class AddUserRefToUserAnserws < ActiveRecord::Migration
  def change
    add_reference :user_anserws , :user, index: true, null: false
  end
end
