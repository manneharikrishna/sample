class Subscription < ApplicationRecord
  STATUSES = %w[inactive active cancelled].freeze

  attr_accessor :redirect_url

  store_accessor :data, :nets_token

  belongs_to :player
  belongs_to :photo

  has_many :deposits

  scope :active, -> { where(status: 'active') }

  validates :player_id, uniqueness: { scope: :status,
      conditions: -> { where(status: 'active') } }

  def active?
    status == 'active'
  end

  def expired?
    expires_on.past?
  end
end
