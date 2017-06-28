class AddFileToMemberFiles < ActiveRecord::Migration[5.1]
  def up
    add_attachment :member_files, :file
  end

  def down
    remove_attachment :member_files, :file
  end
end
