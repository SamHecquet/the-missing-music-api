# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::FestivalsController, type: 'routing' do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: '/v1/festivals/toto').to route_to(
        'api/v1/festivals#show',
        festival_name: 'toto'
      )
    end
  end
end
