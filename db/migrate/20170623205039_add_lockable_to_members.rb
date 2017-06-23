class AddLockableToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :members, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :members, :locked_at, :datetime
    add_index :members, :unlock_token, unique: true
  end
end
