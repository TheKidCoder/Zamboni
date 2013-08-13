require "Zamboni/version"
require 'nokogiri'

Dir[File.dirname(__FILE__) + '/Zamboni/*.rb'].each { |f| require f }

module Zamboni
  BASE_URL = 'http://espn.go.com/nhl'

end
