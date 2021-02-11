class AllowedHostValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil?

    host = Addressable::URI.parse(value).host

    unless allowed_hosts.include?(host)
      record.errors.add(attribute, :host_not_allowed)
    end
  end

  private

  def allowed_hosts
    JSON.parse(ENV.fetch('ALLOWED_HOSTS'))
  end
end
