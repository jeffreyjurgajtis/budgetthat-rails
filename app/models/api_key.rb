class ApiKey < ActiveRecord::Base
  TIME_TO_LIVE = 24

  belongs_to :user

  validates_presence_of :user, :expired_at, :secret

  scope :active, -> { where('expired_at >= ?', Time.zone.now) }
  scope :created_at_desc, -> { order created_at: :desc }
end
