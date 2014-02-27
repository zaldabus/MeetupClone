class Group < ActiveRecord::Base
  attr_accessible :title, :description, :avatar, :owner_id

  before_validation :ensure_group_token

  validates :title, :description, :owner_id, presence: true
  validates :title, uniqueness: true

  belongs_to :owner, class_name: "User", foreign_key: :owner_id

  has_many :group_members
  has_many :events

  has_many :members, through: :group_members

  has_many :notifications, as: :notificationable, dependent: :destroy
  has_many :addresses, as: :addressable, inverse_of: :addressable

  has_attached_file :avatar,
  styles: {
    big: "600x600>",
    small: "50x50>"
  },
  default_url: "/assets/noPhoto_group.png"

  include PgSearch
  multisearchable against: [:title]

  def ensure_group_token
    self.group_token = SecureRandom::urlsafe_base64(16)
  end

  def recent_activity
    activities = []
    activities.concat(self.group_members)

    self.events.each do |event|
      activities.concat(event.event_signups).concat(event.comments)
    end

    activities.sort_by { |activity| activity.created_at }
  end
end
