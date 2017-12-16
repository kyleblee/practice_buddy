class CreateBackingTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :backing_tracks do |t|
      t.string :name
      t.integer :bpm
      t.datetime :last_practiced
      t.string :key
      t.text :description
      t.string :link
      t.integer :artist_id
      t.integer :genre_id

      t.timestamps
    end
  end
end
