module EchoEcho
  class Response
    attr_reader :response
    delegate :status, :start, :total, to: :response
    def initialize(raw_response)
      @response = Hashie::Mash.new(raw_response.parsed_response).response
    end
  end
end