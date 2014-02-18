class User < ActiveRecord::Base
  attr_accessible :name, :email, :avatar, :password
  attr_reader :password

  before_validation :ensure_authenticity_token

  validates :name,
            :email,
            :password_digest,
            :authenticity_token,
            presence: true, uniqueness: true

  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :interests
  has_many :addresses, as: :addressable, inverse_of: :addressable

  has_attached_file :avatar, styles: {
    big: "600x600>",
    small: "50x50>"
  }

  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)

    return nil unless user

    user.has_password?(password) ? user : nil
  end

  def self.generate_token
    SecureRandom::urlsafe_base64(16)
  end

  def has_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end

  def password=(secret)
    @password = secret

    self.password_digest = BCrypt::Password.create(secret)
  end

  def ensure_authenticity_token
    self.authenticity_token = User.generate_token
  end

  def reset_authenticity_token!
    ensure_authenticity_token
    self.save!
    self.authenticity_token
  end
end
