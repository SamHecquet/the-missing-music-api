Rails.application.routes.draw do
  # TODO : add subdomain
  # constraints subdomain: 'api' do
  scope module: 'api' do
    namespace :v1 do
      get '/festivals/:festival_name',
          to: 'festivals#show',
          constraints: { festival_name: /.*/ } # allow slash and dot
      get '/playlists/spotify/create/:festival_slug',
          to: 'playlists#create',
          constraints: { festival_slug: /.*/ } # allow slash and dot
    end
    # end
  end
end
