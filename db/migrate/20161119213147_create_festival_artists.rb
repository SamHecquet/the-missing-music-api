class CreateFestivalArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :festivals_artists do |t|
      t.belongs_to :festival, index: true
      t.belongs_to :artist, index: true
      t.boolean :headliner, :default => false
    end
  end
end
