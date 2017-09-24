# frozen_string_literal: true
module Api
  module V1
    module Playlists
      class SpotifyController < ApiController
        before_action :set_festival, only: [:create, :show]

        # POST /playlists/spotify/create/:festival_slug
        def create
          to_render = []
          if @festival.playlist?
            to_render = PlaylistSerializer.new(
              playlist_name: @festival.name,
              playlist_embed_url: @festival.playlist_embed_url
            )
            # TO REMOVE
            # @festival.remove_playlist
          elsif !@festival.artists.empty?
            error = false
            spotify_generator = SpotifyGenerator.new
            # Catch RestClient::ServerBrokeConnection timeout
            begin
              playlist = spotify_generator.create_playlist(@festival)
            rescue RestClient::ServerBrokeConnection
              error = true
            end
            if playlist.instance_of?(RSpotify::Playlist) && !error
              @festival.add_playlist(playlist.id, spotify_generator.spotify_user.id)
              to_render = PlaylistSerializer.new(
                playlist_name: playlist.name,
                playlist_embed_url: @festival.playlist_embed_url
              )
            end
          end

          render json: to_render
        end

        # GET /playlists/spotify/:festival_slug
        def show
          to_render = []
          if @festival.playlist?
            to_render = PlaylistSerializer.new(
              playlist_name: @festival.name,
              playlist_embed_url: @festival.playlist_embed_url
            )
          end
          render json: to_render
        end

        private

        # Define @festival
        def set_festival
          unless (@festival = Festival.find_one_by_slug(params[:festival_slug]))
            render json: []
          end
          @festival
        end
      end
    end
  end
end
