class Festival < ApplicationRecord
  has_many :festivals_artists
  has_many :artists, through: :festivals_artists
  
  validates :name, presence: true
  validates :url, presence: true
  validates_uniqueness_of :name, :scope => :year

  
  accepts_nested_attributes_for :festivals_artists
  
  # Check if we should try to update the festival in order to have more data
  # @return [Boolean]
  def shouldBeUpdated
    if self.artists.any? and self.updated_at > Date.today-14.hours
      return false
    else
      return true
    end
  end
end
