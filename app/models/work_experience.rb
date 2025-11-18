class WorkExperience < ApplicationRecord
  belongs_to :cv
  default_scope { order(:position) }

  def has_tags? = tags.present?
  def tags_array = tags&.strip&.split(",")&.map(&:strip) || []

  def as_json
    super.tap do |json|
      json.delete("id")
    end
  end
end
