class CreateLicks < ActiveRecord::Migration[5.1]
  def change
    create_table :licks do |t|
      t.string :name
      t.integer :bpm
      t.datetime :last_practiced
      t.datetime :scheduled_practice
      t.string :current_key
      t.text :description
      t.string :link
      t.integer :performance_rating
      t.datetime :date_created
      t.integer :artist_id
      t.integer :user_id

      t.timestamps
    end
  end
end
