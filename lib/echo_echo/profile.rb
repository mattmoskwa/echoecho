module EchoEcho
  class Profile
    # @todo cannot handle artist names in all caps
    attr_accessor :response
    
    ID_REGEX = /[A-Z0-9]{10,}/
    # methods
    # biographies, blogs, discovery, discovery_rank, doc_counts, familiarity, familiarity_rank, genre, hotttnesss, hotttnesss_rank, images, artist_location, news, reviews, songs, terms, urls, video, years_active, id:Rosetta-space
    def self.resource_name
      "artist/profile"
    end
    
    def initialize(name_or_id)
      options = {}
      if name_or_id =~ ID_REGEX
        options[:id] = name_or_id
      elsif 
        options[:name] = name_or_id
      end
      @request = Request.new(self.class.resource_name, options)
    end
    
    
    def id
      @id ||= bucket.id
    end
    
    def name
      @name ||= bucket.name
    end
    
    def self.all_methods
      %i{biographies blogs discovery discovery_rank doc_counts familiarity familiarity_rank genre hotttnesss hotttnesss_rank images artist_location news reviews songs terms urls video years_active}
    end
    
    all_methods.each do |m|
      define_method(m) do 
        val = instance_variable_get :@m
        unless val
          val = bucket(m).send(m)
          instance_variable_set(:@m, val)
        end
        val
      end
    end
    
    private
    
    def bucket(bucket=nil)
      @response = bucket ? @request.get(bucket: bucket) : @request.get
      @id ||= @response.response.artist.id
      @name ||= @response.response.artist.name
      @response.response.artist
    end
  end
end