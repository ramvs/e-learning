class AddTitleToTests < ActiveRecord::Migration
  def change
  	add_column :tests, :title , :string
  	add_column :tests, :description , :string
  end
end
