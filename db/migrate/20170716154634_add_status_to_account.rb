class AddStatusToAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :my_target_accounts, :status, :integer, default: 0
  end
end
