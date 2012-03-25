module YahooNba
  class Query
    
    def initialize(consumer_key, consumer_secret)
      consumer = ::OAuth::Consumer.new(consumer_key,
                                      consumer_secret,
                                      :site => 'http://fantasysports.yahooapis.com',
                                      :http_method => :get) 
      @access_token = OAuth::AccessToken.new(consumer)
    end
   
    def get_players_info_array_starting_at(num)
      players_info_xml = @access_token.get("/fantasy/v2/game/249/players;start=#{num};count=25") 
      players_info_array = Crack::XML.parse(players_info_xml.body)['fantasy_content']['game']['players']['player']
    end

    def get_players_key_hash_from(players_info_array) 
      players_key_hash = {}
      players_info_array.each{|item| players_key_hash[item["name"]["full"]] = item['player_key']}
      players_key_hash
    end

    def get_players_stats_hash_using(players_key_hash)
      players_stats_hash = {}
      players_key_hash.each do |player_name, player_id|
        player_stats_xml = @access_token.get("/fantasy/v2/player/#{player_id}/stats")
        player_stats = Crack::XML.parse(player_stats_xml.body)["fantasy_content"]["player"]
        players_stats_hash[player_name] = player_stats
      end
      players_stats_hash
    end
  end
end
