class AddExternVideoUrlToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :extern_video_url, :string
  end
end
