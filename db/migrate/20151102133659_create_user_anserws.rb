class CreateUserAnserws < ActiveRecord::Migration
  def change
    create_table :user_anserws do |t|
      t.timestamps null: false
      t.references :anserw
    end
  end
end
