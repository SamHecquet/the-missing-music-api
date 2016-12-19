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
end
