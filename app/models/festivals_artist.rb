# frozen_string_literal: true
class FestivalsArtist < ApplicationRecord
  belongs_to :festival
  belongs_to :artist

  scope :headliner_first, -> { order(headliner: :desc) }
  # default_scope -> { order(headliner: :desc) }

  def self.create_headliner(new_artist)
    create(
      artist: new_artist,
      headliner: true
    )
  end
end
