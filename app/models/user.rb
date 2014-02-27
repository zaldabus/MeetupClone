class User < ActiveRecord::Base
  attr_accessible :name, :email, :avatar, :birthday, :password
  attr_reader :password

  before_validation :ensure_authenticity_token

  validates :name,
            :email,
            :password_digest,
            :authenticity_token,
            presence: true, uniqueness: true

  validates :password, length: { minimum: 6, allow_nil: true }

  has_many :interests

  has_many :authentications

  has_many :owned_groups,
           class_name: "Group",
           foreign_key: :owner_id

  has_many :group_members
  has_many :groups, through: :group_members

  has_many :notifications

  has_many :made_comments,
           class_name: "Comment",
           foreign_key: :user_id

  has_many :comments, as: :commentable

  has_many :addresses, as: :addressable, inverse_of: :addressable

  has_attached_file :avatar,
  styles: {
    big: "200x200>",
    small: "40x40>"
  },
  default_url: "/assets/noPhoto_80.png"

  include PgSearch
  multisearchable against: [:name, :email]

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
    self.authenticity_token = User.generate_token if self.authenticity_token.nil?
  end

  def reset_authenticity_token!
    ensure_authenticity_token
    self.save!
    self.authenticity_token
  end

  def apply_omniauth(omniauth)
    authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
  end

  def find_group_member(group)
    self.group_members.find_by_group_id(group.id)
  end

end
