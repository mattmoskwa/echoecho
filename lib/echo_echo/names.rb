module EchoEcho
  module Names
    def resource_name
      name.split("::").last.downcase
    end
  end
end