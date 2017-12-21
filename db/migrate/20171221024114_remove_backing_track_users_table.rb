class RemoveBackingTrackUsersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :backing_track_users
  end
end
