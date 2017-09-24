# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::Playlists::SpotifyController, type: 'routing' do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/v1/playlists/spotify/rock-werchter-2017').to route_to(
        'api/v1/playlists/spotify#create',
        festival_slug: 'rock-werchter-2017'
      )
    end
    it 'routes to #show' do
      expect(get: '/v1/playlists/spotify/rock-werchter-2017').to route_to(
        'api/v1/playlists/spotify#show',
        festival_slug: 'rock-werchter-2017'
      )
    end
  end
end
