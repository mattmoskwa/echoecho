module EchoEcho
	class Artist
    extend Names

    def initialize(name_or_id)
      @resource = Request.new(self.class.resource_name, name: name_or_id)
    end
    
    def biographies
      @resource.get(__method__)
    end
	end
end