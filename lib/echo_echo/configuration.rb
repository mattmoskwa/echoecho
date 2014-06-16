module EchoEcho
  class Configuration
    attr_accessor :api_key, :consumer_key, :shared_secret
    def api_key
      @api_key
    end

    def consumer_key
      @consumer_key
    end

    def shared_secret
      @shared_secret
    end

    def warnings
      { beta: "this is a beta method" }
    end
  end
end