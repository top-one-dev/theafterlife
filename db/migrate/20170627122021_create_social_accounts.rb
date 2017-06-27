class CreateSocialAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :social_accounts do |t|
      t.references :member, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
