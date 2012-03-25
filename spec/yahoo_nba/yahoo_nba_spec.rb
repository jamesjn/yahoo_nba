require 'spec_helper'

describe YahooNba do

	it "allows rspec to work" do
		true.should equal(true)
	end

  describe YahooNba::Query do
    before(:each) do
      @consumer_key = "dj0yJmk9Z3ExYnVlRERPekVDJmQ9WVdrOVlWTnJOV2t6TlRRbWNHbzlNVFEzTnpRd09EUTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD1iNw--"
      @consumer_secret = "a7d3c791b23f35774c608b7863b2d47508560927"  
    end

    it "should have initialize creates a new Query" do
      query = YahooNba::Query.new(@consumer_key, @consumer_secret)
      query.should_not equal(nil)
      query.class.should equal(YahooNba::Query)
    end

    it "should have initialize creates new OAuth::Consumer" do
      OAuth::Consumer.should_receive(:new).with(@consumer_key, @consumer_secret, anything)
      query = YahooNba::Query.new(@consumer_key, @consumer_secret)
    end

    it "should have initialize sets access_token" do
      query = YahooNba::Query.new(@consumer_key, @consumer_secret)
      query.instance_variable_get(:@access_token).should_not equal(nil)
    end

    it "should have get_players_starting_at call get on the access token and parse the response" do
      query = YahooNba::Query.new(@consumer_key, @consumer_secret)
      access_token = query.instance_variable_get(:@access_token) 
      num = 20
      mock_xml = double
      mock_response = double(:body => mock_xml)
      access_token.should_receive(:get).with("/fantasy/v2/game/249/players;start=#{num};count=25").and_return(mock_response)
      Crack::XML.should_receive(:parse).with(mock_xml).and_return({'fantasy_content' => {'game' => {'players' => {'player' => 'right!'}}}})
      query.get_players_info_array_starting_at(num).should == 'right!'
    end

    it "should get players key has from players_info array" do
      players_info_array = [{"player_key"=>"249.p.4244", "player_id"=>"4244", "name"=>{"full"=>"Kevin Durant", "first"=>"Kevin", "last"=>"Durant", "ascii_first"=>"Kevin", "ascii_last"=>"Durant"}, "editorial_player_key"=>"nba.p.4244", "editorial_team_key"=>"nba.t.25", "editorial_team_full_name"=>"Oklahoma City Thunder", "editorial_team_abbr"=>"OKC", "uniform_number"=>"35", "display_position"=>"SF", "image_url"=>"http://l.yimg.com/a/i/us/sp/v/nba/players_l/20101116/4244.jpg?x=46&y=60&xc=1&yc=1&wc=164&hc=215&q=100&sig=OTXf3hs63PFp0fv8wxtCIg--", "is_undroppable"=>"0", "position_type"=>"P", "eligible_positions"=>{"position"=>"SF"}, "has_player_notes"=>"1", "has_recent_player_notes"=>"1"}]
      players_key_hash = {"Kevin Durant"=>"249.p.4244"} 
      query = YahooNba::Query.new(@consumer_key, @consumer_secret)
      hash_results = query.get_players_key_hash_from(players_info_array)
      hash_results.should == players_key_hash
    end

    it "should get players stats using players_key_hash" do
      query = YahooNba::Query.new(@consumer_key, @consumer_secret)
      players_key_hash = {"Kevin Durant"=>"249.p.4244"} 
      access_token = query.instance_variable_get(:@access_token) 
      mock_xml = double
      mock_response = double(:body => mock_xml)
      access_token.should_receive(:get).with("/fantasy/v2/player/#{players_key_hash['Kevin Durant']}/stats").and_return(mock_response)
      Crack::XML.should_receive(:parse).with(mock_xml).and_return({"fantasy_content" => {"player" => "the right stats!"}})
      player_stats_hash = query.get_players_stats_hash_using(players_key_hash)
      player_stats_hash.should == {"Kevin Durant" => "the right stats!"}
    end

  end

end
