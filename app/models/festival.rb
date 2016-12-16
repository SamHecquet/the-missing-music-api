class Festival < ApplicationRecord
  has_many :festivals_artists
  has_many :artists, through: :festivals_artists
  
  validates :name, presence: true
  validates :url, presence: true
  validates_uniqueness_of :name, :scope => :year

  accepts_nested_attributes_for :festivals_artists
    
  def to_s
    "#{@name}"
  end
  
  # Check if we should try to update the festival in order to have more data
  # @return [Boolean]
  def should_be_updated
    self.artists.any? && self.updated_at > 14.hours.ago
  end
end
