require 'open-uri'

module Zamboni
  class Player
    CSS_PATHS = YAML.load_file(File.dirname(__FILE__) + "/scrape_paths/player.yml")
    attr_accessor :id

    def initialize(options = {})
      @id = options[:id] unless options[:id].nil?
    end

    def info_url
      Zamboni::BASE_URL + "/player/_/id/#{@id}"
    end
    def stats_url
      Zamboni::BASE_URL + "/player/stats/_/id/#{@id}"
    end

    def pages
      @pages ||= {
        info: Nokogiri::HTML(open(info_url)),
        stats: Nokogiri::HTML(open(stats_url))
      }
    end

    def stats
      @stats ||= parse_stats
    end


    def info
      @info ||= parse_info
    end


    private
    ###Stats Parsing
    def parse_stats
      stats = []
      seasons = {}
      stats_header = pages[:stats].css(CSS_PATHS['player_stats']['stats_header'])
      season_rows = pages[:stats].css(CSS_PATHS['player_stats']['stats_table'])
      #Grab Stat Headers
      stats_header.children.each do |header_node|
        stats << parse_text_from_node(header_node)
      end

      season_rows.each_with_index do |season_row, i|
        if i > 0 #Do this to skip the first row (when we have Nokogiri 1.6.1 this wont be ness.)
          cell_data = {}
          season_row.children.each_with_index do |cell, j|
            cell_data[stats[j]] = parse_text_from_node(cell) if j > 0
          end
          seasons[parse_text_from_node(season_row.children.first)] = cell_data
        end
      end

      return seasons
    end

    ###Info Parsing
    def parse_info
      info = {}
      CSS_PATHS['player_info'].each do |n, path|
        node = pages[:info].css(path)
        info[n] = parse_text_from_node(node)
      end
      info
    end

    ###Node Helpers
    def parse_text_from_node(node)
      if node.children && node.children.length > 0
        if node.at_css('a')
          return node.css('a').text
        else
          return node.xpath('text()').text
        end
      else
        return node.inner_text
      end
    end
  end
end