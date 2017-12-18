class AddDefaultValueToUserAdmin < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :admin, :boolean, default: false
  end
end
