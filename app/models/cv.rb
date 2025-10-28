class Cv < ApplicationRecord
  validates :name, :email_address, presence: true
end
