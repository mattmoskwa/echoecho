module EchoEcho
  # @todo Rate-limit
  # @todo Error-handling
  # @todo look into const_missing and dynamically create classes
  class Request
    API_KEY = EchoEcho.config.api_key
    CONSUMER_KEY = EchoEcho.config.consumer_key 
    SHARED_SECRET = EchoEcho.config.shared_secret 
    include HTTParty
    base_uri "developer.echonest.com"
    logger ::Logger.new(STDOUT), :info, :curl
    disable_rails_query_string_format
    # def initialize(resource_name, params={})
    #   @resource = RestClient::Resource.new("http://developer.echonest.com/api/v4/#{resource_name}")
    #   @params = params.merge(api_key: API_KEY, format: "json")
    # end
    # 
    # def get(params={})
    #   method = params.delete :method
    #   @params.merge! params
    #   raw_response = @resource["/#{method}"].get(params: @params)
    #   Response.new(raw_response)
    # end
    def initialize(resource, params={})
      @params = params.merge(api_key: API_KEY, format: "json")
      @resource = resource
    end
    
    def get(params={})
      method = params.delete(:method)
      raw_response = self.class.get("/api/v4/#{@resource}/#{method}", query: params.merge(@params))
      Response.new(raw_response)
    end
  end
end