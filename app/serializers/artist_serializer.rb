# frozen_string_literal: true
class ArtistSerializer < ActiveModel::Serializer
  attributes :name, :spotify_id, :slug
end
