module Controllers
  module JSONHelpers
    def json
      @json ||= JSON.parse response.body
    end
  end
end
