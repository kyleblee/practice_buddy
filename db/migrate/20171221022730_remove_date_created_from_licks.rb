class RemoveDateCreatedFromLicks < ActiveRecord::Migration[5.1]
  def change
    remove_column :licks, :date_created
  end
end
