# frozen_string_literal: true
class Festival < ApplicationRecord
  has_many :festivals_artists, dependent: :destroy
  has_many :artists, through: :festivals_artists

  validates :name, presence: true
  validates :url, presence: true
  validates_uniqueness_of :name, scope: 'year'

  accepts_nested_attributes_for :festivals_artists

  def to_s
    @name
  end

  # Check if we should try to update the festival in order to have more data
  # @return [Boolean]
  def should_be_updated?
    artists.empty? || updated_at < 14.hours.ago
  end

  # Check the festival has data to retrieve its playlist
  # @return [Boolean]
  def playlist?
    spotify_user_id.present? && spotify_playlist_id.present?
  end

  def self.find_one_by_name_and_year(festival_name, festival_slug, year)
    where(
      [
        '(lower(name) = ? OR lower(slug) = ?) AND year =?',
        festival_name,
        festival_slug,
        year
      ]
    ).first
  end

  def self.search_by_name(festival_name)
    where('short_name % ?', festival_name)
      .order("similarity(short_name, #{ActiveRecord::Base.connection.quote(festival_name)}) DESC, year DESC")
      .limit(6)
  end

  def self.find_one_by_slug(festival_slug)
    where(slug: festival_slug).take
  end

  # Remove playlist's ids
  def remove_playlist
    update(spotify_user_id: nil, spotify_playlist_id: nil)
  end

  # Update Festival model to add playlist's ids
  # @param playlist_id [String]
  # @param spotify_user_id [String]
  def add_playlist(playlist_id, spotify_user_id)
    update(
      spotify_user_id: spotify_user_id,
      spotify_playlist_id: playlist_id
    )
  end

  #  Format : https://embed.spotify.com/?uri=spotify:user:{user}:playlist:{playlist}
  def playlist_embed_url
    "https://embed.spotify.com/?uri=spotify:user:#{spotify_user_id}:playlists:#{spotify_playlist_id}" if playlist?
  end
end
