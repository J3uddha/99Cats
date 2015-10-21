class User < ActiveRecord::Base

  validates :user_name, :session_token, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)

    return nil unless user.password_digest.is_password?(password)
    user
  end

  def password_digest
    BCrypt::Password.new(super)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  after_initialize :ensure_session_token

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    #current user class method?
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def is_password?(password)
    password_digest == BCrypt::Password.create(password)
  end

end
