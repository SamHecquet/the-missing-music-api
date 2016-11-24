Rails.application.routes.draw do
  # TODO : add subdomain
  # constraints subdomain: 'api' do
  scope module: 'api' do
    namespace :v1 do
      get '/festivals/:festival_name', to: 'festivals#show', :constraints => { :festival_name => /.*/} # allow slash and dot
    end
  # end
  end
end
