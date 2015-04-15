class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :description
      t.integer :course_id , null: false
      t.timestamps null: false
    end
  end
end
