class FestivalsArtist < ApplicationRecord
  belongs_to :festival  
  belongs_to :artist  
  
  default_scope -> { order(headliner: :desc) }
end
