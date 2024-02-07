class MuseumObject < ApplicationRecord
  validates :system_number, presence: true, uniqueness: true, format: { with: /\AO\d+\z/ , message: "must be in correct format"}
end
