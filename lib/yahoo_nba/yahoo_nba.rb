require_relative 'player_includes'

module YahooNba
  class Query
    include PlayerIncludes
    
    def initialize(consumer_key, consumer_secret)
      consumer = ::OAuth::Consumer.new(consumer_key,
                                      consumer_secret,
                                      :site => 'http://fantasysports.yahooapis.com',
                                      :http_method => :get) 
      @access_token = OAuth::AccessToken.new(consumer)
      @player_key_hash = player_key_hash
    end
   
    def get_players_info_array_starting_at(num)
      players_info_xml = @access_token.get("/fantasy/v2/game/249/players;start=#{num};count=25") 
      players_info_array = Crack::XML.parse(players_info_xml.body)['fantasy_content']['game']['players']['player']
    end

    def get_players_key_hash_from(players_info_array) 
      players_key_hash = {}
      players_info_array.each do |item| 
        players_key_hash[item["name"]["full"]] = item['player_key']
      end
      players_key_hash
    end

    def get_players_stats_hash_using(players_key_hash)
      players_stats_hash = {}
      players_key_hash.each do |player_name, player_key|
        player_stats = get_player_stats_hash_with_player_key(player_key)
        players_stats_hash[player_name] = player_stats
      end
      players_stats_hash
    end

    def get_player_stats_hash_with_player_key(player_key)
      player_stats_xml = @access_token.get("/fantasy/v2/player/#{player_key}/stats")
      player_stats = Crack::XML.parse(player_stats_xml.body)["fantasy_content"]["player"]
    end

    def get_player_stats_hash_with_player_name(player_name)
      get_player_stats_hash_with_player_key(@player_key_hash[player_name])
    end

    def get_all_player_keys_hash
      combined_array = []
      0.step(500, 25) do |n|
        combined_array = combined_array | get_players_info_array_starting_at(n)
      end
      get_players_key_hash_from(combined_array)
    end

    def get_stats_categories
      stats_categories_xml = @access_token.get("/fantasy/v2/game/nba/stat_categories")
      stats_categories_hash = Crack::XML.parse(stats_categories_xml.body)["fantasy_content"]["game"]["stat_categories"]["stats"]
    end 
  end
end
