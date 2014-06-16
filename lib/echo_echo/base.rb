module EchoEcho
  # This is the class that all entity classes (e.g. Artist, Genre) inherit from
  # It provides the basic request/response handling
  class Base
    def self.resource_name
      raise NotImplementedError
    end

    def self.last_response
      @response
    end

    def self.get(options)
      @response = Request.new(resource_name).get(options)
    end
  end
end