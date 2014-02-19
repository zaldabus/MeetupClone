class Event < ActiveRecord::Base
  attr_accessible :title, :description, :date, :location, :group_id

  validates :title, :description, :date, :location, :group_id, presence: true

  belongs_to :group

  has_many :event_signups, class_name: "EventSignup", foreign_key: :event_id

  has_many :attendees, through: :event_signups, source: :attendee

  has_many :addresses, as: :addressable, inverse_of: :addressable

  has_attached_file :avatar,
  styles: {
    big: "600x600>",
    small: "50x50>"
  },
  default_url: "/assets/noPhoto_80.png"
end
