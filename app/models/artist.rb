class Artist < ApplicationRecord
  has_many :festivals_artists
  has_many :festivals, through: :festivals_artists

  validates :name, presence: true
  validates :slug, presence: true
  
  def to_s
    "#{@name}"
  end
end
