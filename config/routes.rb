# frozen_string_literal: true
Rails.application.routes.draw do
  # TODO : add subdomain
  # constraints subdomain: 'api' do
  scope module: 'api' do
    namespace :v1 do
      get '/festivals/search/:festival_name',
          to: 'festivals#search',
          constraints: { festival_name: /.*/ } # allow slash and dot
      post '/festivals/:festival_name',
           to: 'festivals#create',
           constraints: { festival_name: /.*/ } # allow slash and dot
      get '/festivals/:festival_name',
          to: 'festivals#show',
          constraints: { festival_name: /.*/ } # allow slash and dot
      namespace :playlists do
        post '/spotify/:festival_slug',
             to: 'spotify#create',
             constraints: { festival_slug: /.*/ } # allow slash and dot
        get '/spotify/:festival_slug',
            to: 'spotify#show',
            constraints: { festival_slug: /.*/ } # allow slash and dot
      end
    end
    # end
  end
end
