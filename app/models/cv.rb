class Cv < ApplicationRecord
  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts

  has_many :education_items, dependent: :destroy
  accepts_nested_attributes_for :education_items

  has_many :languages, dependent: :destroy
  accepts_nested_attributes_for :languages

  # Creates and associates an empty Contact, setting it's position as last.
  def add_contact
    max_position = contacts.map(&:position).max || 0
    Contact.new(contact_type: "generic", position: max_position + 1).tap { |record| contacts << record }
  end

  def delete_contact(contact)
    id = contact.respond_to?(:id) ? contact.id : contact.to_i
    Contact.delete(id)
  end

  # Creates and associates an empty EducationItem, setting it's position as last.
  def add_education_item
    max_position = education_items.map(&:position).max || 0
    EducationItem.new(position: max_position + 1).tap { |record| education_items << record }
  end

  def delete_education_item(education_item)
    id = education_item.respond_to?(:id) ? education_item.id : education_item.to_i
    EducationItem.delete(id)
  end

  # Creates and associates an empty Language, setting it's position as last.
  def add_language
    max_position = languages.map(&:position).max || 0
    Language.new(position: max_position + 1).tap { |record| languages << record }
  end

  def delete_language(language)
    id = language.respond_to?(:id) ? language.id : language.to_i
    Language.delete(id)
  end
end
