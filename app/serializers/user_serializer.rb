class UserSerializer < ActiveModel::Serializer
  attributes :email, :token

  def token
    @options[:token]
  end
end
