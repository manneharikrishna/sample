class Photo < ApplicationRecord
  belongs_to :player

  has_many :entries, dependent: :nullify
  has_many :subscriptions

  mount_uploader :image, PhotoUploader

  validates :image, presence: true

  def default?
    player.nil?
  end

  def played?
    entries.any?
  end

  def subscribed?
    subscriptions.any?
  end
end
