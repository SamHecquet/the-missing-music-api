# frozen_string_literal: true
class SlugGenerator
  # Rewrite the name of the festival provided
  #
  # @param festival_name [String]
  # @param year [Integer]
  # @return [Array] List of rewrited names
  #
  # * festival_name + year
  # * festival_name + additional_word(s) + year
  # * festival_name
  # * "the" + festival_name + year
  # * "the" + festival_name + additional_word(s) + year
  def self.to_slug(festival_name, year)
    list_festival_name = []

    # strip and downcase the string
    rewrited_name = festival_name.strip.downcase

    # blow away apostrophes
    rewrited_name.gsub!(/['`’]/, '')

    # & --> and
    rewrited_name.gsub!(/\s*&\s*/, ' and ')

    # replace all non alphanumeric, underscore or periods with dash
    rewrited_name.gsub!(/\s*[^A-Za-z0-9]\s*/, '-')

    # remove word "the" if starting by it
    rewrited_name.gsub!(/^the/, '-')

    # remove frequently used words like "festival", we'll add them manually
    add_words = Rails.configuration.behaviour['scrapping']['add_words']
    add_words.each do |word|
      rewrited_name.sub!(word, '')
    end

    # remove current year, last one and next
    rewrited_name.sub!(year.to_s, '')
    rewrited_name.sub!((year.to_i - 1).to_s, '')
    rewrited_name.sub!((year.to_i + 1).to_s, '')

    # convert multiple dashes to single
    rewrited_name.gsub!(/-+/, '-')

    # strip off leading/trailing dash
    rewrited_name.gsub!(/\A[-\.]+|[-\.]+\z/, '')

    # now the name is cleaned, we can add other possible names
    # * festival_name + 2017
    list_festival_name << "#{rewrited_name}-#{year}"

    # Manually add frequently used words like "festival"
    add_words.each do |word|
      # * festival_name + "word" + 2017
      list_festival_name << "#{rewrited_name}-#{word.tr(' ', '-')}-#{year}"
    end
    # * festival_name
    list_festival_name << rewrited_name

    # * "the" + festival_name + 2017
    list_festival_name << "the-#{rewrited_name}"

    # Manually add frequently used words like "festival"
    add_words.each do |word|
      # * "the" + festival_name + word + 2017
      list_festival_name << "the-#{rewrited_name}-#{word.tr(' ', '-')}-#{year}"
    end
    # puts list_festival_name

    list_festival_name
  end
end
