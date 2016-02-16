module Controllers
  module JSONHelpers
    def json
      @json ||= JSON.parse response.body
    end
  end

  module AuthHelpers
    def set_auth_headers(user)
      result = CreateApiKey.new(user_id: user.id).create!

      request.headers['X-USER-EMAIL'] = user.email
      request.headers['X-USER-TOKEN'] = result.token
    end
  end
end
