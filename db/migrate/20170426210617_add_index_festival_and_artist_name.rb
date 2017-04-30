class AddIndexFestivalAndArtistName < ActiveRecord::Migration[5.0]
  def change
    add_index :festivals, :name
    add_index :artists, :name
  end
end
