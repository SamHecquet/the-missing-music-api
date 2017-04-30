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
    rewrited_name = clean_raw_name festival_name

    # now the name is cleaned, we can add other possible names
    # * festival_name + 2017
    list_festival_name << "#{rewrited_name}-#{year}"

    # Manually add frequently used words like "festival"
    add_words = Rails.configuration.behaviour['scrapping']['add_words']
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

    list_festival_name
  end


  def self.clean_raw_name(raw_name)
    # strip and downcase the string
    rewrited_name = raw_name.strip.downcase

    # blow away apostrophes
    rewrited_name.gsub!(/['`’]/, '')

    # & --> and
    rewrited_name.gsub!(/\s*&\s*/, ' and ')

    # replace word "the" if starting by it
    #         all non alphanumeric, underscore or periods with dash
    rewrited_name.gsub!(/^the|\s*[^A-Za-z0-9]\s*/, '-')

    # remove frequently used words like "festival", we'll add them manually
    Rails.configuration.behaviour['scrapping']['add_words'].each do |word|
      rewrited_name.sub!(word, '')
    end

    # remove year
    rewrited_name.gsub!(/20\d{2}/, '')

    # convert multiple dashes to single
    rewrited_name.gsub!(/-+/, '-')

    # strip off leading/trailing dash
    rewrited_name.gsub!(/\A[-\.]+|[-\.]+\z/, '')
    
    rewrited_name
  end
end
