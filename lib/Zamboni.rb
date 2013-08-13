require "Zamboni/version"
require 'nokogiri'
require 'open-uri'
require 'YAML'

Dir[File.dirname(__FILE__) + '/Zamboni/*.rb'].each { |f| require f }

module Zamboni
  BASE_URL = 'http://espn.go.com/nhl'

end
