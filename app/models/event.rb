class Event < ActiveRecord::Base
  attr_accessible :title, :description, :date, :time, :avatar, :group_id

  validates :title, :description, :date, :time, :group_id, presence: true

  belongs_to :group

  has_many :event_signups, class_name: "EventSignup", foreign_key: :event_id

  has_many :attendees, through: :event_signups, source: :attendee

  has_many :comments, as: :commentable
  has_many :addresses, as: :addressable, inverse_of: :addressable

  #Avatar currently not being used with events, consider
  #removing from model
  has_attached_file :avatar,
  styles: {
    big: "600x600>",
    small: "50x50>"
  },
  default_url: "/assets/noPhoto_80.png"
end
