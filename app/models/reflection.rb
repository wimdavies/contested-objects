class Reflection < ApplicationRecord
  belongs_to :user
  belongs_to :museum_object

  validates :deaccession_flag, presence: true, inclusion: [true, false]
end
