unless Rails.env.production?
  Bullet.enable = true
  Bullet.bullet_logger = true
end
