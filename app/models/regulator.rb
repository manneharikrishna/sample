class Regulator < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, email: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  def active?
    true
  end
end
