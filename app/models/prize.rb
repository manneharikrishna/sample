class Prize < ApplicationRecord
  REVEAL_TYPES = [:instant, :drawing_end].freeze

  belongs_to :prizeable, polymorphic: true

  has_many :tickets
  has_many :entries, through: :tickets

  mount_uploader :image, PrizeImageUploader

  scope :instant, -> { where(reveal_type: :instant) }
  scope :weekly, -> { where(reveal_type: :drawing_end) }

  def physical?
    description.present?
  end
end
