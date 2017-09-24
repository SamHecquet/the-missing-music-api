# frozen_string_literal: true
class FestivalSerializer < ActiveModel::Serializer
  attributes :name, :url, :slug, :year, :playlist_embed_url, :playlist_uri, :location,
             :date, :ticket, :camping, :website

  has_many :festivals_artists, key: :artists

  def playlist_embed_url
    object.playlist_embed_url
  end

  def playlist_uri
    object.playlist_uri
  end
end
