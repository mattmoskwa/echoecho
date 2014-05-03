module EchoEcho
  class Response
    attr_reader :response
    def initialize(raw_response, method)
      json = JSON.parse(raw_response)
      @response = Hashie::Mash.new(json).response
      @method = method
      define_singleton_method(@method) { @response.send @method}

    end
    
    def status
      response.status
    end
    
    def start
      response.start
    end
    
    def total
      response.total
    end
    
    # def method_missing(method)
    #   if method == @method
    #     @response.send(method)
    #   else 
    #     super
    #   end
    # end
  end
end