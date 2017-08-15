class AddInstructionIvToSensitiveInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :sensitive_infos, :encrypted_instruction_iv, :string
  end
end
