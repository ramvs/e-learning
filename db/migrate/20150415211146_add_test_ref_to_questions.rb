class AddTestRefToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :test, index: true
    add_foreign_key :questions, :tests
  end
end
