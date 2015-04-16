class AddLessonRefToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :lesson, index: true
    add_foreign_key :documents, :lessons
  end
end
