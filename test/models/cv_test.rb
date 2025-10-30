require "test_helper"

class CvTest < ActiveSupport::TestCase
  test "Can have all attributes empty" do
    cv = Cv.new

    assert cv.valid?
  end

  test '#add_contact adds a new empty Contact with updated position and type "generic"' do
    contact = nil
    cv = Cv.new

    assert_difference("cv.contacts.size", 1) { contact = cv.add_contact }

    assert contact.value.blank?
    assert_equal "generic", contact.contact_type
    assert_equal 1, contact.position

    assert_difference("cv.contacts.size", 1) { contact = cv.add_contact }
    assert_equal 2, contact.position
  end

  test "#delete_contact destroys a Contact record but does not update the other positions" do
    cv = cvs(:two)
    first_id = cv.contacts.first.id
    second_position = cv.contacts.second.position

    assert_difference("cv.contacts.count", -1) { cv.delete_contact(first_id) }
    assert_equal second_position, cv.contacts.reload.first.position
    assert_difference("cv.contacts.count", -1) { cv.delete_contact(cv.contacts.first) }
  end

  test "#add_education_item adds a new empty Education_Item with updated position" do
    education_item = nil
    cv = Cv.new

    assert_difference("cv.education_items.size", 1) { education_item = cv.add_education_item }
    assert education_item.name.blank?
    assert education_item.location.blank?
    assert education_item.date.blank?
    assert_equal 1, education_item.position

    assert_difference("cv.education_items.size", 1) { education_item = cv.add_education_item }
    assert_equal 2, education_item.position
  end

  test "#delete_education_item destroys a Education_Item record but does not update the other positions" do
    cv = cvs(:two)
    first_id = cv.education_items.first.id
    second_position = cv.education_items.second.position

    assert_difference("cv.education_items.count", -1) { cv.delete_education_item(first_id) }
    assert_equal second_position, cv.education_items.reload.first.position
    assert_difference("cv.education_items.count", -1) { cv.delete_education_item(cv.education_items.first) }
  end

  test "#add_language adds a new empty Language with updated position" do
    language = nil
    cv = Cv.new

    assert_difference("cv.languages.size", 1) { language = cv.add_language }

    assert language.name.blank?
    assert language.level.blank?
    assert_equal 1, language.position

    assert_difference("cv.languages.size", 1) { language = cv.add_language }
    assert_equal 2, language.position
  end

  test "#delete_language destroys a Language record but does not update the other positions" do
    cv = cvs(:two)
    first_id = cv.languages.first.id
    second_position = cv.languages.second.position

    assert_difference("cv.languages.count", -1) { cv.delete_language(first_id) }
    assert_equal second_position, cv.languages.reload.first.position
    assert_difference("cv.languages.count", -1) { cv.delete_language(cv.languages.first) }
  end
end
