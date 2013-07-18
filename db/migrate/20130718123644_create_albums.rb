class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :album
      t.string :artist
      t.string :host
      t.timestamp :played_on

      t.timestamps
    end
  end
end
