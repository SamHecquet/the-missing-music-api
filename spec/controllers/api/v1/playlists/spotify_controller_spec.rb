# frozen_string_literal: true
require 'rails_helper'

describe Api::V1::Playlists::SpotifyController, type: 'controller' do
  describe '#create' do
    before(:each) do
      create(:festival_with_playlist)
      create(:festival_empty)
      create(:werchter_radiohead)
    end

    context 'when festival_slug already has a playlist' do
      it 'return a json answer with the playlist\'s name and url' do
        get :create, params: { festival_slug: 'festival-with-playlist' }
        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json['playlist_name']).to eq('festival with playlist')
        expect(json['playlist_embed_url']).to eq('https://embed.spotify.com/?uri=spotify:user:spotify_user_id:playlists:spotify_playlist_id')
      end
    end

    context 'when festival_slug doesnt have any playlist and lineup' do
      it 'return a json answer empty' do
        get :create, params: { festival_slug: 'festival-empty' }
        expect(response).to be_success
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'when festival_slug is a festival with a lineup and no playlist' do
      it 'return a json answer empty' do
        VCR.use_cassette('create:standard:spotify:playlist') do
          get :create, params: { festival_slug: 'rock-werchter-2017' }
        end
        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json['playlist_name']).to eq('Rock Werchter 2017')
        expect(json['playlist_embed_url']).to eq('https://embed.spotify.com/?uri=spotify:user:samhecquet:playlists:5ju2eLbnG4lrgm2nPFptWq')
      end
    end
  end
end
