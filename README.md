# Zamboni

While working on an NHL god's website, we needed easy access to player stats and team schedules. ESPN has an API, but its pretty terrible unless your a super-duper-fabulous-partner.
Thus, Zamboni was born. A simple screen scraping gem for NHL player & team info.

Btw, that god was this guy:

![Pascha](http://i.imgur.com/6LvfP99.gif)

## Installation

Add this line to your application's Gemfile:

    gem 'Zamboni'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Zamboni

## Usage

Because our project is based on a single player, we simple sub-classed Zamboni::Player

    class Pavel < Zamboni::Player
    end

set the id from ESPN

    class Pavel < Zamboni::Player
      def initialize
        @id = 1223
      end
    end

and then call instance methods like .season_stats or info.

    pavel = new Pavel
    pavel.info['name'] #Pavel Datsyuk
    pavel.info['age'] #34

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
