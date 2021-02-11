require 'securerandom'

module RNG
  def self.random_number(limit)
    SecureRandom.random_number(limit)
  end
end
