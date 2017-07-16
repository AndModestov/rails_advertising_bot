class CreateMyTargetAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :my_target_accounts do |t|
      t.string :name
      t.string :login
      t.string :password
      t.string :link
      
      t.timestamps
    end
  end
end
