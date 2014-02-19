class EventSignup < ActiveRecord::Base
  attr_accessible :attendee_id, :event_id

  validates :attendee_id, :event_id, presence: true
  validates :attendee_id, uniqueness: { scope: :event_id }

  belongs_to :attendee, class_name: "User", foreign_key: :attendee_id
  belongs_to :event

end
