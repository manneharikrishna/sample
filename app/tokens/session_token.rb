class SessionToken < UserToken
  def expires_at
    15.minutes.from_now
  end
end
