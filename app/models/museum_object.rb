class MuseumObject < ApplicationRecord
  has_many :reflections
  has_many :users, through: :reflections

  validates :system_number, presence: true, uniqueness: true, format: { with: /\AO\d+\z/ , message: "must be in correct format"}
  validates :name, presence: true
end
