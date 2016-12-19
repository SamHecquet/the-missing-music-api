require 'open-uri'

module Api::V1
  class FestivalsController < ApiController
    before_action :log_search, only: [:show]
    before_action :set_festival, only: [:show]
    after_action  :log_result, only: [:show]

    # GET /festivals/:name
    def show
      if @festival.instance_of?(Festival) && @festival.valid?
        render json: @festival
      else
        # Default answer
        puts '404'
        render json: []
      end
    end

    private

    def log_search
      # TODO
      puts 'log_search'
    end

    def set_festival
      # Default value
      @festival = nil

      # 1 - Rewrite
      list_festival_name_rewrited = to_slug(
        params[:festival_name],
        year = Date.today.strftime('%Y').to_i
      )

      # 2 - Search in database
      search_festival_database(list_festival_name_rewrited, year)

      # 3 - Search by scrapping if Festival not found
      #     or it still doesn't have any artists
      search_festival_scrapping(list_festival_name_rewrited, year) if need_scrapping?
    end

    # Rewrite the name of the festival provided
    #
    # @param festival_name [String]
    # @param year [Integer]
    # @return [Array] List of rewrited names
    # * festival_name + year
    # * festival_name + festival + year
    # * festival_name
    # * the + festival_name + year
    # * the + festival_name + festival + year
    def to_slug(festival_name, year)
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

      # remove word "festival", we'll add it manually after
      rewrited_name.sub!('festival', '')

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

      # * festival_name + festival + 2017
      list_festival_name << "#{rewrited_name}-festival-#{year}"

      # * festival_name
      list_festival_name << rewrited_name

      # * the + festival_name + 2017
      list_festival_name << "the-#{rewrited_name}"

      # * the festival_name + festival + 2017
      list_festival_name << "the-#{rewrited_name}-festival-#{year}"

      list_festival_name
    end

    # Search festival's data in database
    #
    # @param list_festival_name [Array]
    # @param year [Integer]
    # @return [Festival, nil] if found, return festival's data
    def search_festival_database(list_festival_name, year)
      # try to find festival's in database for each name
      list_festival_name.each do |festival_name|
        festival = Festival.find_one_by_name_and_year(
          festival_name.tr('-', ' '),
          festival_name,
          year
        )
        if festival
          @festival = festival
          break
        end
      end
    end

    # Search festival's data by scrapping
    #
    # @param list_festival_name [Array]
    # @param year [Integer]
    # @return [Festival, nil] if found, return festival's data
    def search_festival_scrapping(list_festival_name, year)
      # try to find festival's data for each name
      list_festival_name.each do |festival_name|
        url = "#{Rails.configuration.behaviour['scrapping']['base_url']}#{festival_name}/"

        # First we ping the URL to see if it exists
        resp = Net::HTTP.get_response(URI.parse(url))
        next unless /20\d/ =~ resp.code
        # then we scrap
        page = Nokogiri::HTML(open(url))
        # create Festival if necessary
        if @festival.instance_of?(Festival) && @festival.valid?
          festival = @festival
        else
          params = ActionController::Parameters.new(
            festival: {
              name: page.css('header.entry-header.wrapper h1 span').text,
              slug: festival_name,
              url:  url,
              year:  year
            }
          )
          festival = Festival.create(params.require(:festival).permit!)
        end
        
        # headliners
        page.css('.placeholder2 .f_headliner .f_artist').each do |name|
          artist_name = name.text
          slug = artist_name.strip
                            .downcase.gsub(/\A\p{Space}*|\p{Space}*\z/, '')
          # Search Artist in database before creating it
          new_artist = Artist.create_if_not_found(artist_name, slug)
          next if !new_artist.valid? || festival.artists.include?(new_artist)
          festival.festivals_artists.create_headliner(new_artist)
        end

        # lineup
        page.css('.lineupguide ul li').each do |name|
          artist_name = name.text
          slug = artist_name.strip
                            .downcase.gsub(/\A\p{Space}*|\p{Space}*\z/, '')
          # Search Artist in database before creating it
          new_artist = Artist.create_if_not_found(artist_name, slug)
          next if !new_artist.valid? || festival.artists.include?(new_artist)
          festival.artists << new_artist
        end

        # Save and return Festival
        if festival.instance_of?(Festival) && festival.valid? && festival.save
          @festival = festival
        end
      end
    end

    def log_result
      # TODO
      puts 'log_result'
    end

    # Determine if the festival need to be searched or updated
    # @return [Boolean]
    def need_scrapping?
      !@festival.instance_of?(Festival) || !@festival.valid? || @festival.should_be_updated?
    end
  end
end
