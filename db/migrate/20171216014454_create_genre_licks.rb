class CreateGenreLicks < ActiveRecord::Migration[5.1]
  def change
    create_table :genre_licks do |t|
      t.integer :genre_id
      t.integer :lick_id

      t.timestamps
    end
  end
end
