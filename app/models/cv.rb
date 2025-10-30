class Cv < ApplicationRecord
  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts

  has_many :education_items, dependent: :destroy
  accepts_nested_attributes_for :education_items

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

  # Creates and associates an empty EducationItem at the end of the
  # #education_items association.
  def add_education_item
    max_position = education_items.maximum(:position) || 0
    education_items << EducationItem.new(position: max_position + 1)
    self
  end

  def delete_education_item(education_item)
    id = education_item.respond_to?(:id) ? education_item.id : education_item.to_i
    EducationItem.delete(id)
    self
  end
end
