class CreateLickTonalities < ActiveRecord::Migration[5.1]
  def change
    create_table :lick_tonalities do |t|
      t.integer :lick_id
      t.integer :tonality_id

      t.timestamps
    end
  end
end
