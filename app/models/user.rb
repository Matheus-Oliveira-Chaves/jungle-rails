class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 5 }

  def admin?
    self.email == ENV['ADMIN_EMAIL'] && self.authenticate(ENV['ADMIN_PASSWORD'])
  end

  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    user && user.authenticate(password)
  end
end