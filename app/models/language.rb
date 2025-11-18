class Language < ApplicationRecord
  belongs_to :cv
  default_scope { order(:position) }

  def as_json
    super.tap do |json|
      json.delete("id")
    end
  end
end
