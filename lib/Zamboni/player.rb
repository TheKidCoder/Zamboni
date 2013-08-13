require 'open-uri'

module Zamboni
  class Player
    CSS_PATHS = YAML.load_file(File.dirname(__FILE__) + "/scrape_paths/player.yml")
    attr_accessor :id
    def initialize(options = {})
      @id = options[:id] unless options[:id].nil?
    end

    def player_url
      Zamboni::BASE_URL + "/player/_/id/#{@id}"
    end

    def doc
      @doc ||= Nokogiri::HTML(open(player_url))
    end

    def stats
      @stats ||= basic_stats
    end

    def player_info
      info = {}
      CSS_PATHS['player_info'].each do |n, path|
        node = doc.css(path)
        if node.children.length > 0
          info[n] = node.xpath('text()').text
        else
          info[n] = node.inner_text
        end
      end
      info
    end
  end
end