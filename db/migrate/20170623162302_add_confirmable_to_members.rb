class AddConfirmableToMembers < ActiveRecord::Migration[5.1]
  def up
    add_column :members, :confirmation_token, :string
    add_column :members, :confirmed_at, :datetime
    add_column :members, :confirmation_sent_at, :datetime
    add_column :members, :unconfirmed_email, :string
    add_index :members, :confirmation_token, unique: true
    
    Member.all.update_all confirmed_at: Time.now
  end

  def down
    remove_columns :members, :confirmation_token, :confirmed_at, :confirmation_sent_at
    remove_columns :members, :unconfirmed_email
  end
end
