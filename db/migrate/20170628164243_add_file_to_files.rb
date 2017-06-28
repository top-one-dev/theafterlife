class AddFileToFiles < ActiveRecord::Migration[5.1]
  def up
    add_attachment :files, :file
  end

  def down
    remove_attachment :files, :file
  end
end
