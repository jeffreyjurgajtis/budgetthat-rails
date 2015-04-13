class UserSerializer < ActiveModel::Serializer
  attributes :email, :access_token

  def access_token
    object.session_api_key.access_token
  end
end
