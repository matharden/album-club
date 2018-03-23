class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :track_number
      t.string :name
      t.integer :duration
      t.references :album, index: true

      t.timestamps
    end
  end
end
