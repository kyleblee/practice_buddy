class CreateArtistUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :artist_users do |t|
      t.integer :artist_id
      t.integer :user_id

      t.timestamps
    end
  end
end
