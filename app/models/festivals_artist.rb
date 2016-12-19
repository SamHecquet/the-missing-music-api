class FestivalsArtist < ApplicationRecord
  belongs_to :festival
  belongs_to :artist

  scope :headliner_first, -> { order(headliner: :desc) }
  default_scope -> { order(headliner: :desc) }
end
