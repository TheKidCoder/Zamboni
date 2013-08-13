module Zamboni
  class Team
    CSS_PATHS = YAML.load_file(File.dirname(__FILE__) + "/scrape_paths/team.yml")

    attr_accessor :name

    def initialize(options = {})
      @name = options[:name] unless options[:name].nil?
      pages #Preload the pages on init.
      return self
    end

    def pages
      @pages ||= {
        schedule: Nokogiri::HTML(open(schedule_url))
      }
    end

    def schedule
      @schedules ||= parse_schedule
    end

    private
    def schedule_url
      Zamboni::BASE_URL + "/team/schedule/_/name/#{@name}"
      # Zamboni::BASE_URL + "/teams/printSchedule?team=#{@name}&season=2014"
    end

    def parse_schedule
      schedules = {}
      schedule_rows = pages[:schedule].css(CSS_PATHS['team_schedule']['table'])

      last_schedule = ""
      current_schedule = ""
      schedule_rows.children.each do |row|
        next if row['class'] == 'stathead' or row['class'] == 'colhead'
        schedules[row.children[0].text] = {
          opponent: {name: row.children[1].css('.team-name a').text, url: row.children[1].css('.team-name a').first['href']},
          time: row.children[2].text,
          location: row.children[6].text
        }
      end

      return schedules
    end
  end
end