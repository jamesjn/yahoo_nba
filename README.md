# YahooNba

This gem uses the YAHOO Sports API to retrieve stats for NBA players

## Installation

Add this line to your application's Gemfile:

    gem 'yahoo_nba'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yahoo_nba

## Usage

This gem assists in retrieving player keys and player stats using the Yahoo Sports API.

require 'yahoo_nba'
query = YahooNba::Query.new 'your_consumer_key', 'your_consumer_secret'
(to obtain a key, go to http://developer.yahoo.com/)

To get a hash with all the player keys:
player_keys_hash = query.get_all_player_keys_hash

The hash will be in the format:
{"Player Name"=>"key123", "Player2 Name"=> "key234"}

To get nba player stats:
query.get_players_stats_hash_using(players_keys_hash)

The hash will be in the format returned by the Yahoo Sports API.  

For more information see:
http://developer.yahoo.com/fantasysports/guide/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
