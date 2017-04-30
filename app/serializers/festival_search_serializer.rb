# frozen_string_literal: true
class FestivalSearchSerializer < ActiveModel::Serializer
  attributes :name, :url, :slug, :year
end
