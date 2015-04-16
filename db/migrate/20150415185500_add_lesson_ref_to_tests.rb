class AddLessonRefToTests < ActiveRecord::Migration
  def change
    add_reference :tests, :lesson, index: true , null: false
    add_foreign_key :tests, :lessons
  end
end
