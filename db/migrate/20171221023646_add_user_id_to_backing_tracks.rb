class AddUserIdToBackingTracks < ActiveRecord::Migration[5.1]
  def change
    add_column :backing_tracks, :user_id, :integer
  end
end
