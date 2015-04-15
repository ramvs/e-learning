class AddQuestionRefToAnserws < ActiveRecord::Migration
  def change
    add_reference :anserws, :question, index: true
    add_foreign_key :anserws, :questions
  end
end
