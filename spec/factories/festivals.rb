FactoryGirl.define do
  factory :festival_with_playlist, class: Festival do
    name 'festival with playlist'
    slug 'festival-with-playlist'
    url 'url'
    year 2000
    location 'location'
    date 'date'
    ticket 'ticket'
    camping false
    website 'website'
    spotify_playlist_id 'spotify_playlist_id'
    spotify_user_id 'spotify_user_id'
  end

  factory :festival_empty, class: Festival do
    name 'festival empty'
    slug 'festival-empty'
    url 'url'
    year 2000
    location 'location'
    date 'date'
    ticket 'ticket'
    camping false
    website 'website'
    spotify_playlist_id nil
    spotify_user_id nil
  end

  factory :werchter, class: Festival do
    name 'Rock Werchter 2017'
    slug 'rock-werchter-2017'
    url 'https://www.musicfestivalwizard.com/festivals/rock-werchter-2017/'
    year 2017
    location nil
    date nil
    ticket nil
    camping false
    website nil
    spotify_playlist_id nil
    spotify_user_id nil
  end
  factory :radiohead, class: Artist do
    name 'Radiohead'
    slug 'radiohead'
    spotify_id nil
  end

  factory :werchter_radiohead, class: FestivalsArtist do
    association :artist, factory: :radiohead
    association :festival, factory: :werchter
  end
end
