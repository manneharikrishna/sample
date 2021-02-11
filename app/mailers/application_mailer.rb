class ApplicationMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  add_template_helper EmailHelper

  layout 'mailer'

  default from: "#{LOCAL_APP_NAME} <#{NO_REPLY_EMAIL_ADDRESS}>"
end
