require 'spec_helper'

describe YahooNba do
	it "allows rspec to work" do
		true.should equal(true)
	end

  describe YahooNba::Query do
    it "creates a new Query" do
      query = YahooNba::Query.new("key", "secret")
      query.should_not equal(nil)
      query.class.should equal(YahooNba::Query)
    end
  end

end
