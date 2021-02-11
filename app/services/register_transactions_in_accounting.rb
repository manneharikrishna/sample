class RegisterTransactionsInAccounting
  def initialize(type, date = Date.yesterday)
    @type = type.to_s
    @date = date
  end

  def call
    save_bundle_list if transactions.present?
  end

  private

  attr_reader :type
  attr_reader :date

  def transactions
    @transactions ||= model.completed.from_date(date)
  end

  def model
    @model ||= type.classify.constantize
  end

  def save_bundle_list
    TwentyFourSevenOffice::SaveBundleList.new(message).call
  end

  def message
    TwentyFourSevenOffice::MessageBuilder.build(:bundle_list, bundle: bundle)
  end

  def bundle
    bundle_class.new(transactions)
  end

  def bundle_class
    TwentyFourSevenOffice.const_get("#{model}Bundle")
  end
end
