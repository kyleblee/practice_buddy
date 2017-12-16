class CreateBackingTrackUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :backing_track_users do |t|
      t.integer :backing_track_id
      t.integer :user_id

      t.timestamps
    end
  end
end
