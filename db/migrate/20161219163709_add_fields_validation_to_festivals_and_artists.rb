class AddFieldsValidationToFestivalsAndArtists < ActiveRecord::Migration[5.0]
  def change
    change_column_null(:festivals, :name, false)
    change_column_null(:festivals, :slug, false)
    change_column_null(:artists, :name, false)
    change_column_null(:artists, :slug, false)
    
    add_index(:festivals, [:name, :year], unique: true)
    add_index(:festivals_artists, [:festival_id, :artist_id], unique: true)
  end
end
