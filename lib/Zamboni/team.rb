module Zamboni
  class Team
    CSS_PATHS = YAML.load_file(File.dirname(__FILE__) + "/scrape_paths/team.yml")

    attr_accessor :name

    def initialize(options = {})
      @name = options[:name] || "DET"
      @season = options[:season] || "20132014"
      @gameType = options[:playoffs] ? 3 : 2
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
      "http://www.nhl.com/ice/schedulebyseason.htm?season=#{@season}&gameType=#{@gameType}&team=#{@name}"
    end

    def parse_schedule
      schedule = {}
      schedule_rows = pages[:schedule].css(CSS_PATHS[:team_schedule][:table])

      schedule_rows.children.each do |row|
        schedule[row.css(CSS_PATHS[:team_schedule][:date]).text] = {
          away_team:      (row.css('.team')[0].text rescue ""),
          home_team:      (row.css('.team')[1].text rescue ""),
          time_est:       row.css('td.time .skedStartTimeEST').text,
          network_result: row.css('.tvInfo').text.strip
        }
      end
      schedule
    end

  end
end