class UserSerializer < ActiveModel::Serializer
  attributes :email, :token

  def token
    ApiKeyGenerator.new(user_id: object.id).token!
  end
end
