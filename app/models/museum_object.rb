class MuseumObject < ApplicationRecord
  validates :system_number, presence: true, uniqueness: true
end
