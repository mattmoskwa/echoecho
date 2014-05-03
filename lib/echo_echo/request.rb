module EchoEcho
  # @todo Rate-limit
  # @todo Error-handling
  class Request
    API_KEY = "YIFPP93UIBIGE7PT6"
    CONSUMER_KEY = "8817e87f22fcc2b57da139ecf7db37e9"
    SHARED_SECRET = "0plZDM5mSRGfTpB23KwWyg"
    def initialize(resource_name, params={})
      @resource = RestClient::Resource.new("http://developer.echonest.com/api/v4/#{resource_name}")
      @params = params.merge(api_key: API_KEY)
    end
    
    def get(method)
      raw_response = @resource["/#{method}"].get(params: @params)
      Response.new(raw_response, method)
    end
  end
end