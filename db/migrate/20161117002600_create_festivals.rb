class CreateFestivals < ActiveRecord::Migration[5.0]
  def change
    create_table :festivals do |t|
      t.string :name
      t.string :slug
      t.string :url
      t.integer :year
      t.string :location
      t.string :date
      t.string :ticket
      t.boolean :camping
      t.string :website
      t.string :spotify_playlist_id
      t.string :spotify_user_id

      t.timestamps
    end
  end
end
