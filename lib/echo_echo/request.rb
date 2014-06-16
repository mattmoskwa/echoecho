module EchoEcho
  # @todo Rate-limit
  # @todo Error-handling
  # @todo look into const_missing and dynamically create classes
  class Request

    include HTTParty
    base_uri "developer.echonest.com/api/v4/"
    logger ::Logger.new(STDOUT), :info, :curl

    # By default, the param format for arrays is ?array[]=1&array[]=2, etc
    # This is a rails convention
    # The echonest API does not support this convention, so turn it off (thanks HTTParty!)
    disable_rails_query_string_format

    def self.api_key
      @api_key ||= EchoEcho.config.api_key
    end

    def initialize(resource, params={})
      @params = params.merge(api_key: self.class.api_key, format: "json")
      @resource = resource
    end

    def get(params={})
      method = params.delete(:method)
      raw_response = self.class.get("/#{@resource}/#{method}", query: params.merge(@params))
      Response.new(raw_response)
    end
  end
end