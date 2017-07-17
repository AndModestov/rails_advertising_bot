class CreateMyTargetPads < ActiveRecord::Migration[5.0]
  def change
    create_table :my_target_pads do |t|
      t.string :name
      t.integer :service_id
      t.integer :account_id

      t.timestamps
    end

    add_index :my_target_pads, :account_id
  end
end
