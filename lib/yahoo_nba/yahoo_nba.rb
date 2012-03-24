module YahooNba
  class Query
    def initialize(consumer_key, consumer_secret)
      @consumer = ::OAuth::Consumer.new(consumer_key,
                                      consumer_secret,
                                      :site => 'http://fantasysports.yahooapis.com',
                                      :http_method => :get
                                     ) 
                                      
    end
  end
end
