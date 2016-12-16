class FestivalSerializer < ActiveModel::Serializer
  attributes :name, :url, :slug, :year, :location, :date, :ticket, :camping, :website, :playlist_url
  
  has_many :festivals_artists, key: :artists
  
  #  Format : https://api.spotify.com/v1/users/{user_id}/playlists/{playlist_id}
  def playlist_url
    "https://api.spotify.com/v1/users/#{object.spotify_user_id}/playlists/#{object.spotify_playlist_id}" if object.spotify_user_id && object.spotify_playlist_id
  end
end
