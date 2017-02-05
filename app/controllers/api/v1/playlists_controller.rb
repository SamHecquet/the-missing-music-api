module Api
  module V1
    class PlaylistsController < ApiController
      before_action :set_festival, only: [:create]

      # GET /playlists/spotify/create/:festival_slug
      def create
        to_render = []
        if @festival.instance_of?(Festival)
          if @festival.playlist?
            to_render = PlaylistSerializer.new(
              playlist_name: @festival.name,
              playlist_embed_url: @festival.playlist_embed_url
            )
            @festival.remove_playlist
          elsif !@festival.artists.empty?
            error = false
            # Catch RestClient::ServerBrokeConnection timeout
            begin
              playlist = create_playlist
            rescue RestClient::ServerBrokeConnection
              error = true
            end
            if playlist.instance_of?(RSpotify::Playlist) && !error
              add_playlist(playlist.id)
              to_render = PlaylistSerializer.new(
                playlist_name: playlist.name,
                playlist_embed_url: @festival.playlist_embed_url
              )
            end
          end
        end

        render json: to_render
      end

      private

      # Define @festival
      def set_festival
        @festival = Festival.find_one_by_slug(params[:festival_slug])
      end

      # Create and return a Spotify playlist
      #
      # @return [RSpotify::Playlist]
      def create_playlist
        @spotify_user = RSpotify::User.new(
          Rails.configuration.oauth_tokens['spotify']['oauth_tokens'].with_indifferent_access
        )
        playlist = @spotify_user.create_playlist!(@festival.name)
        @festival.artists.each do |artist|
          artists = RSpotify::Artist.search(artist.name)
          next if artists.empty?
          top_tracks = artists.first.top_tracks(:US)
          playlist.add_tracks!(top_tracks[0..1]) unless top_tracks.empty?
        end
        playlist
      end

      # Update Festival model to add playlist's ids
      # @param playlist_id [String]
      #
      # @return [Festival]
      def add_playlist(playlist_id)
        @festival.update(
          spotify_user_id: @spotify_user.id,
          spotify_playlist_id: playlist_id
        )
      end
    end
  end
end
