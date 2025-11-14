class Contact < ApplicationRecord
  belongs_to :cv
  default_scope { order(:position) }

  TYPES = %i[generic email github linkedin phone]
end
