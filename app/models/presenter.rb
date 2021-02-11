class Presenter < ApplicationRecord
  has_secure_password

  validates :password, length: { minimum: 8 }, allow_nil: true

  def activated?
    true
  end
end
