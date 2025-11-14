class Language < ApplicationRecord
  belongs_to :cv
  default_scope { order(:position) }
end
