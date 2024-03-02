class User < ApplicationRecord
  has_secure_password


def admin?
  self.email == ENV['ADMIN_EMAIL'] && self.authenticate(ENV['ADMIN_PASSWORD'])
  
end
end