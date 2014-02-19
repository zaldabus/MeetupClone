class EventSignup < ActiveRecord::Base
  attr_accessible :attendee_id, :event_id

  validates :attendee_id, :event_id, presence: true
  validates :attendee_id, uniqueness: { scope: :event_id }

  belongs_to :attendee
  belongs_to :event

  has_many :addresses, as: :addressable, inverse_of: :addressable

  has_attached_file :avatar, styles: {
    big: "600x600>",
    small: "50x50>"
  }
end
