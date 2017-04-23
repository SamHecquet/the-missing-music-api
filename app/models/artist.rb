# frozen_string_literal: true
class Artist < ApplicationRecord
  has_many :festivals_artists, dependent: :destroy
  has_many :festivals, through: :festivals_artists

  validates :name, presence: true
  validates :slug, presence: true

  def to_s
    @name
  end

  def self.find_one_by_name(artist_name, slug)
    where(
      [
        'lower(name) = ? OR lower(slug) = ?',
        artist_name,
        slug
      ]
    ).first
  end

  def self.create_if_not_found(artist_name, slug)
    new_artist = find_one_by_name(artist_name, slug)
    new_artist = new(name: artist_name, slug: slug) unless new_artist
    new_artist
  end
end
