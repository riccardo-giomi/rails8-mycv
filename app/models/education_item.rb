class EducationItem < ApplicationRecord
  belongs_to :cv
  default_scope { order(:position) }
end
