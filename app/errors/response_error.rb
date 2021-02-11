class ResponseError < ApplicationError
  attr_reader :status

  def initialize(status, message = nil)
    if message.nil?
      super(status.to_s.titleize)
    else
      super(I18n.t(message, scope: 'errors.messages'))
    end

    @status = status
  end
end
