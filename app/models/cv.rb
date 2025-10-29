class Cv < ApplicationRecord
  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts

  # Creates and associates an empty Contact at the end of the #contacts
  # association.
  def add_contact
    max_position = contacts.maximum(:position) || 0
    contacts << Contact.new(contact_type: "generic", position: max_position + 1)
    self
  end

  def delete_contact(contact)
    id = contact.respond_to?(:id) ? contact.id : contact.to_i
    Contact.delete(id)
    self
  end
end
