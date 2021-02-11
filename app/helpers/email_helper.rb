module EmailHelper
  def inline_image_tag(name)
    path = Rails.root.join('app', 'assets', name)

    attachments.inline[name] = File.read(path)

    halved_width = Dimensions.width(path) / 2
    halved_height = Dimensions.height(path) / 2

    size = "#{halved_width}x#{halved_height}"

    image_tag(attachments.inline[name].url, size: size)
  end

  def greeting(user)
    if user_name(user).present?
      I18n.t('layouts.mailer.user_greeting', name: user_name(user))
    else
      I18n.t('layouts.mailer.greeting')
    end
  end

  private

  def user_name(user)
    case user
    when Player then user.first_name
    when Regulator then user.name
    end
  end
end
