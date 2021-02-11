class Consultant < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates :password, presence: true

  def active?
    true
  end
end
