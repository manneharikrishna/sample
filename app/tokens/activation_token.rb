class ActivationToken < UserToken
  private

  def expires_at
    2.days.from_now
  end
end
