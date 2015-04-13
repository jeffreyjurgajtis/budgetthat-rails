class User < ActiveRecord::Base
  has_secure_password

  validates :email, uniqueness: true, format: { with: /@/ }

  has_many :api_keys, dependent: :destroy
  has_many :budget_sheets, dependent: :destroy

  def session_api_key
    ApiKeyGenerator.new(id).first_or_create
  end
end
