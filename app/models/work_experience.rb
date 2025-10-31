class WorkExperience < ApplicationRecord
  belongs_to :cv

  def has_tags? = tags.present?
  def tags_array = tags&.strip&.split(",")&.map(&:strip) || []
end
