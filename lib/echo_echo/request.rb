module EchoEcho
  # @todo Rate-limit
  # @todo Error-handling
  class Request
    API_KEY = "YIFPP93UIBIGE7PT6"
    CONSUMER_KEY = "8817e87f22fcc2b57da139ecf7db37e9"
    SHARED_SECRET = "0plZDM5mSRGfTpB23KwWyg"
    def initialize
      @resource = RestClient::Resource.new("http://developer.echonest.com/api/v4/")
    end
    
    def get
    end
  end
end