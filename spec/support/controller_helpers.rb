module Controllers
  module JSONHelpers
    def json
      @json ||= JSON.parse response.body
    end
  end

  module AuthHelpers
    def set_auth_headers(user, token = nil)
      token ||= ApiKeyGenerator.new(user_id: user.id).token!

      request.headers['X-USER-EMAIL'] = user.email
      request.headers['X-USER-TOKEN'] = token
    end
  end
end
