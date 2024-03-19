class Reflection < ApplicationRecord
  belongs_to :user
  belongs_to :museum_object

  validates :deaccession_flag, presence: true, inclusion: [true, false]
  validate :at_least_one_text_response_required

  def at_least_one_text_response_required
    text_fields = [deaccession_reason, provenance_thoughts, presence_feelings, absence_feelings]
    if text_fields.all?(&:blank?)
      errors.add :base, :text_response, message: "You must write a response to at least one prompt"
    end
  end
end
