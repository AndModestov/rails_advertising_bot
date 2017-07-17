class CreateMyTargetAddunits < ActiveRecord::Migration[5.0]
  def change
    create_table :my_target_addunits do |t|
      t.string :name
      t.integer :service_id
      t.integer :pad_id
      t.integer :format

      t.timestamps
    end

    add_index :my_target_addunits, :pad_id
  end
end
