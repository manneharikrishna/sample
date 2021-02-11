class LotteryDurationValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.nil? || value.to_i.zero?

    unless contain_in_duration(value, lottery_duration(record))
      record.errors.add(attribute, :lottery_duration_exceeded)
    end
  end

  private

  def contain_in_duration(value, duration)
    (duration / value.to_i).positive?
  end

  def lottery_duration(lottery)
    lottery.ends_at.to_i - lottery.starts_at.to_i
  end
end
