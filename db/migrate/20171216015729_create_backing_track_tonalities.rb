class CreateBackingTrackTonalities < ActiveRecord::Migration[5.1]
  def change
    create_table :backing_track_tonalities do |t|
      t.integer :backing_track_id
      t.integer :tonality_id

      t.timestamps
    end
  end
end
