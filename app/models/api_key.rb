class ApiKey < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :expired_at, :access_token
  validates_uniqueness_of :access_token
end
