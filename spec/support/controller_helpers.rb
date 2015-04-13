module Controllers
  module JSONHelpers
    def json
      @json ||= JSON.parse response.body
    end
  end

  module AuthHelpers
    def set_access_token_header(access_token)
      request.headers['X-ACCESS-TOKEN'] = access_token
    end
  end
end
