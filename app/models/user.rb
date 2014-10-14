class User < ActiveRecord::Base
  before_save { self.email = email.downcase }

  # Auth

  has_secure_password

  #
  # Validations
  #

  validates :name,
            presence: true,
            length: { maximum: 20 }

  validates :password,
            length: { minimum: 6 }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: EMAIL_REGEX }
end
