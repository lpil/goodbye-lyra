class User < ActiveRecord::Base
  before_create :create_remember_token
  before_save { self.email = email.downcase }

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

  #
  # Logic
  #

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end
end
