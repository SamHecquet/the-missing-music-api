# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::FestivalsController, type: 'routing' do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: '/v1/festivals/toto').to route_to(
        'api/v1/festivals#create',
        festival_name: 'toto'
      )
    end
    it 'routes to #show' do
      expect(get: '/v1/festivals/toto').to route_to(
        'api/v1/festivals#show',
        festival_name: 'toto'
      )
    end
    it 'routes to #search' do
      expect(get: '/v1/festivals/search/toto').to route_to(
        'api/v1/festivals#search',
        festival_name: 'toto'
      )
    end
  end
end
