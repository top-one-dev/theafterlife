class RenameColumnsInSensitiveInfos < ActiveRecord::Migration[5.1]
  def change
    rename_column :sensitive_infos, :instruction, :encrypted_instruction
  end
end
