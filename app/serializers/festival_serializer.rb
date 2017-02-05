class FestivalSerializer < ActiveModel::Serializer
  attributes :name, :url, :slug, :year, :playlist_embed_url, :location,
             :date, :ticket, :camping, :website

  has_many :festivals_artists, key: :artists

  def playlist_embed_url
    object.playlist_embed_url
  end
end
