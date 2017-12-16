class CreateTunes < ActiveRecord::Migration[5.1]
  def change
    create_table :tunes do |t|
      t.string :name
      t.datetime :last_practiced
      t.datetime :scheduled_practice
      t.string :key
      t.string :link
      t.text :description
      t.integer :performance_rating
      t.integer :user_id
      t.integer :artist_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
