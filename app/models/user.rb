class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true, format: { with: /@/ }

  has_many :api_keys, dependent: :destroy
end
