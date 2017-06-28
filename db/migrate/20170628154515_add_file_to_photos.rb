class AddFileToPhotos < ActiveRecord::Migration[5.1]
  def up
    add_attachment :photos, :file
  end

  def down
    remove_attachment :photos, :file
  end
end
