# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::PlaylistsController, type: 'routing' do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/v1/playlists/spotify/create/rock-werchter-2017').to route_to(
        'api/v1/playlists#create',
        festival_slug: 'rock-werchter-2017'
      )
    end
  end
end
