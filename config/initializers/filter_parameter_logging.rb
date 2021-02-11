# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [
  :token,
  :password,
  :new_password,
  :bankid_code,
  :first_name,
  :last_name,
  :birthdate,
  :phone_number,
  :bank_account_number,
  :avatar,
  :image,
  :cover
]
