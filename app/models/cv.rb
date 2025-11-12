class Cv < ApplicationRecord
  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts

  has_many :education_items, dependent: :destroy
  accepts_nested_attributes_for :education_items

  has_many :languages, dependent: :destroy
  accepts_nested_attributes_for :languages

  has_many :work_experiences, dependent: :destroy
  accepts_nested_attributes_for :work_experiences

  has_one :layout, dependent: :destroy
  accepts_nested_attributes_for :layout, update_only: true

  after_initialize do |cv|
    cv.layout = Layout.new if cv.id.nil?
  end

  # Creates and associates an empty Contact, setting it's position as last.
  def add_contact
    max_position = contacts.map(&:position).max || 0
    Contact.new(contact_type: "generic", position: max_position + 1).tap { |record| contacts << record }
  end

  def delete_contact(contact)
    id = contact.respond_to?(:id) ? contact.id : contact.to_i
    contacts.delete(Contact.find(id))
  end

  # Creates and associates an empty EducationItem, setting it's position as last.
  def add_education_item
    max_position = education_items.map(&:position).max || 0
    EducationItem.new(position: max_position + 1).tap { |record| education_items << record }
  end

  def delete_education_item(education_item)
    id = education_item.respond_to?(:id) ? education_item.id : education_item.to_i
    education_items.delete(EducationItem.find(id))
  end

  # Creates and associates an empty Language, setting it's position as last.
  def add_language
    max_position = languages.map(&:position).max || 0
    Language.new(position: max_position + 1).tap { |record| languages << record }
  end

  def delete_language(language)
    id = language.respond_to?(:id) ? language.id : language.to_i
    languages.delete(Language.find(id))
  end

  # Creates and associates an empty WorkExperience, setting it's position as last.
  def add_work_experience
    max_position = work_experiences.map(&:position).max || 0
    WorkExperience.new(position: max_position + 1).tap { |record| work_experiences << record }
  end

  def delete_work_experience(work_experience)
    id = work_experience.respond_to?(:id) ? work_experience.id : work_experience.to_i
    work_experiences.delete(WorkExperience.find(id))
  end
end
