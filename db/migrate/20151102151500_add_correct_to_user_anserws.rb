class AddCorrectToUserAnserws < ActiveRecord::Migration
  def change
    add_column :user_anserws, :correct, :boolean, default: false
  end
end
