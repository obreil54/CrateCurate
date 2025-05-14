class CreatePlaylistTracks < ActiveRecord::Migration[8.0]
  def change
    create_table :playlist_tracks do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
