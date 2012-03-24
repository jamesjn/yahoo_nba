require 'spec_helper'

describe YahooNba do

	it "allows rspec to work" do
		true.should equal(true)
	end

  describe YahooNba::Query do

    it "initialize creates a new Query" do
      consumer_key = "dj0yJmk9Z3ExYnVlRERPekVDJmQ9WVdrOVlWTnJOV2t6TlRRbWNHbzlNVFEzTnpRd09EUTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeDw--"
      consumer_secret = "a7d3c791b23f35774c608b7863b2d475085609"
      @query = YahooNba::Query.new(consumer_key, consumer_secret)
      @query.should_not equal(nil)
      @query.class.should equal(YahooNba::Query)
    end

    it "initialize creates new OAuth::Consumer" do
      consumer_key = "dj0yJmk9Z3ExYnVlRERPekVDJmQ9WVdrOVlWTnJOV2t6TlRRbWNHbzlNVFEzTnpRd09EUTJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeDw--"
      consumer_secret = "a7d3c791b23f35774c608b7863b2d475085609"
      OAuth::Consumer.should_receive(:new).with(consumer_key, consumer_secret, anything)
      @query = YahooNba::Query.new(consumer_key, consumer_secret)
    end

  end

end
