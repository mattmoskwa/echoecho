module EchoEcho
  class Configuration
    attr_accessor :api_key, :consumer_key, :shared_secret
    def api_key
      @api_key || "YIFPP93UIBIGE7PT6"
    end
    
    def consumer_key
      @consumer_key || "8817e87f22fcc2b57da139ecf7db37e9"
    end
    
    def shared_secret
      @shared_secret || "0plZDM5mSRGfTpB23KwWyg"
    end
    
    def warnings
      { beta: "this is a beta method" }
    end
  end
end