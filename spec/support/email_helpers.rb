module EmailHelpers
  def deliveries
    ActionMailer::Base.deliveries
  end
end
