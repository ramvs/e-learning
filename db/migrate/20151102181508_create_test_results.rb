class CreateTestResults < ActiveRecord::Migration
  def change
    create_table :test_results do |t|
      t.integer :max , null: false
      t.integer :points, null: false
      t.references :user, null: false
      t.references :test, null: false
      t.index [:user_id, :test_id] , unique: true
      t.timestamps null: false
    end

    remove_reference :user_anserws , :user
    add_reference :user_anserws , :test_result, null: false
    add_index :user_anserws , [:anserw_id, :test_result_id]
  end
end
