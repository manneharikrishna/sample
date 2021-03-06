def norway?
  COUNTRY_CODE == 'NO'
end

def sweden?
  COUNTRY_CODE == 'SE'
end

CURRENCY = ENV.fetch('CURRENCY') { 'NOK' }
COUNTRY_CODE = ENV.fetch('COUNTRY_CODE') { 'NO' }

APPLICATION_NAME = ENV.fetch('APPLICATION_NAME') { 'SnapChance' }
LOCAL_APP_NAME = APPLICATION_NAME + '.' + COUNTRY_CODE.downcase { 'SnapChance.no' }
APPLICATION_DOMAIN = ENV.fetch('APPLICATION_DOMAIN') { 'snapchance.no' }

COMPANY_NAME = ENV.fetch('COMPANY_NAME') { 'SnapChance.no AS' }
COMPANY_ADDRESS = ENV.fetch('COMPANY_ADDRESS') { 'Stortingsgaten 30, 0161 Oslo, Norway' }

SUPPORT_EMAIL_ADDRESS = "support@#{APPLICATION_DOMAIN}".freeze
NO_REPLY_EMAIL_ADDRESS = "no-reply@#{APPLICATION_DOMAIN}".freeze

ENV.fetch('BALANCE_LIMIT')
ENV.fetch('TRANSFER_LIMIT')
ENV.fetch('WEEKLY_LOSS_LIMIT')
ENV.fetch('DAILY_LOSS_LIMIT')

ENV.fetch('FAILED_SESSION_LIMIT')

ENV.fetch('ALLOWED_HOSTS')

ENV.fetch('WEEKLY_LOTTERY_REDIRECT_URL')
ENV.fetch('PROFILE_REDIRECT_URL')
ENV.fetch('DASHBOARD_REDIRECT_URL')
