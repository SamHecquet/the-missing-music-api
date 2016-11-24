class FestivalsArtistSerializer < ActiveModel::Serializer 
  attributes :name, :slug, :headliner, :spotify_id
  
  def name
    return object.artist.name
  end  
  
  def slug
    return object.artist.slug
  end
  
  def spotify_id
    return object.artist.spotify_id
  end
  
end