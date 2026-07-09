class Contact < ApplicationRecord
  belongs_to :cv
  default_scope { order(:position) }

  TYPES = %i[generic email github linkedin phone location]

  def as_json
    super.tap do |json|
      json.delete("id")
    end
  end
end
