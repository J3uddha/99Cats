class User < ActiveRecord::Base

  validates :user_name, :session_token, :password_digest, presence: true

  after_initialize :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password
    @password
  end

  def is_password?(password)
    password_digest == BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64
  end


  def User::find_by_credentials(user_name, password)
    return nil unless is_password?(password)
    user = User.where("user_name = ?", user_name: user_name)
  end
end
