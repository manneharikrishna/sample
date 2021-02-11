class AbstractForm < Reform::Form
  def initialize
    super(nil)
  end

  def self.property(name, options = {})
    super(name, options.merge(virtual: true))
  end
end
