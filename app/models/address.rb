class Address < ActiveRecord::Base
  attr_accessible :address_line, :city, :state, :zip_code

  validates :addressable, :address_line, :city, :state, :zip_code, presence: true

  belongs_to :addressable, polymorphic: true
end
