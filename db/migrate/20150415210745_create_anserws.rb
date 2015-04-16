class CreateAnserws < ActiveRecord::Migration
  def change
    create_table :anserws do |t|
      t.string :content , null: false
      t.boolean :correct

      t.timestamps null: false
    end
  end
end
