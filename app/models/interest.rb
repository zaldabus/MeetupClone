class Interest < ActiveRecord::Base
  attr_accessible :title

  validates :title, presence: true

  belongs_to :user
end
