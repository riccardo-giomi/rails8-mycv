class Contact < ApplicationRecord
  belongs_to :cv

  TYPES = %i[generic email github linkedin phone]
end
