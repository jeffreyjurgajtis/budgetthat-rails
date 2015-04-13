class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :authentication_token

  def authentication_token
    object.session_api_key.access_token
  end
end
