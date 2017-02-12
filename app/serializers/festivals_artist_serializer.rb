class FestivalsArtistSerializer < ActiveModel::Serializer
  attributes :name, :slug, :spotify_id

  def name
    object.artist.name
  end

  def slug
    object.artist.slug
  end

  def spotify_id
    object.artist.spotify_id
  end
end
