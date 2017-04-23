# frozen_string_literal: true
class SpotifyGenerator
  # <RSpotify::User>
  attr_reader :spotify_user

  def initialize
    @spotify_user = RSpotify::User.new(
      Rails.configuration.oauth_tokens['spotify']['oauth_tokens'].with_indifferent_access
    )
  end

  # Create and return a Spotify playlist
  #
  # @return [RSpotify::Playlist]
  def create_playlist(festival)
    playlist = @spotify_user.create_playlist!(festival.name)
    festival.artists.each do |artist|
      artists = RSpotify::Artist.search(artist.name)
      next if artists.empty?
      top_tracks = artists.first.top_tracks(:US)
      playlist.add_tracks!(top_tracks[0..1]) unless top_tracks.empty?
    end
    playlist
  end
end
