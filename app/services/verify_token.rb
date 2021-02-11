class VerifyToken
  include UserHelper

  def initialize(token, user_type, type)
    @token = token
    @user_type = user_type
    @type = type
  end

  def call
    user if type_valid?
  end

  private

  attr_reader :token
  attr_reader :user_type
  attr_reader :type

  def type_valid?
    payload[:type] == type.to_s
  end

  def user
    user_class.find_by(id: user_id)
  end

  def user_id
    payload["#{user_type}_id"]
  end

  def payload
    @payload ||= JSONWebToken.decode(token) || {}
  end
end
