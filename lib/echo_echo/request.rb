module EchoEcho
  # @todo Rate-limit
  # @todo Error-handling
  # @todo look into const_missing and dynamically create classes
  class Request
    API_KEY = EchoEcho.config.api_key
    CONSUMER_KEY = EchoEcho.config.consumer_key 
    SHARED_SECRET = EchoEcho.config.shared_secret 
    include HTTParty
    base_uri "developer.echonest.com/api/v4/"
    logger ::Logger.new(STDOUT), :info, :curl
    
    # By default, the param format for arrays is ?array[]=1&array[]=2, etc
    # This is a rails convention
    # The echonest API does not support this convention, so turn it off (thanks HTTParty!)
    disable_rails_query_string_format
    
    def initialize(resource, params={})
      @params = params.merge(api_key: API_KEY, format: "json")
      @resource = resource
    end
    
    def get(params={})
      method = params.delete(:method)
      raw_response = self.class.get("/#{@resource}/#{method}", query: params.merge(@params))
      Response.new(raw_response)
    end
  end
end