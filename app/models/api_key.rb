class ApiKey < ActiveRecord::Base
  TIME_TO_LIVE = 24.hours

  belongs_to :user

  validates_presence_of :user, :expired_at, :access_token
  validates_uniqueness_of :access_token

  scope :active, -> { where('expired_at >= ?', Time.zone.now) }
end
