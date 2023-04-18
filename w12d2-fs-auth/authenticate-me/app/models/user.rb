class User < ApplicationRecord
  # given to us: 
    # create password setter and getter
    # validate presence of password
    # defines User#authenticate(password)
  has_secure_password

  #validations
  validates :username, :email, :session_token, presence: true, uniqueness: true
  validates :username, length: { in: 3..30 }, format: { without: URI::MailTo::EMAIL_REGEXP, message: "cannot be an email" }
  validates :email, length: { in: 3..255 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { in: 6..255, allow_nil: true }

  before_validation :ensure_session_token

  #SPIRE
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user&.authenticate(password)
        user
    else
        nil
    end
  end

  def reset_session_token!
    self.session_token = generate_unique_session_token
    self.save!
    self.session_token
  end

  private
  def generate_unique_session_token
    token = SecureRandom::urlsafe_base64
    while User.exists?(session_token: token)
      token = SecureRandom::urlsafe_base64
    end
    token
  end

  def ensure_session_token
    self.session_token ||= generate_unique_session_token
  end

end
