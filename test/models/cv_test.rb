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

  test "#delete_contact marks the contact for destruction when the Cv is saved" do
    cv = cvs(:two)
    first_id = cv.contacts.first.id

    assert_difference("cv.contacts.count", -1) do
      cv.delete_contact(first_id)
      cv.save
    end
  end

  test "#add_education_item adds a new empty EducationItem with updated position" do
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

  test "#delete_education_item marks the EducationItem for destruction when the Cv is saved" do
    cv = cvs(:two)
    first_id = cv.education_items.first.id
    second_position = cv.education_items.second.position

    assert_difference("cv.education_items.count", -1) do
      cv.delete_education_item(first_id)
      cv.save
    end
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

  test "#delete_language marks the Language for destruction when the Cv is saved" do
    cv = cvs(:two)
    first_id = cv.languages.first.id
    second_position = cv.languages.second.position

    assert_difference("cv.languages.count", -1) do
      cv.delete_language(first_id)
      cv.save
    end
  end

  test "#add_work_experience adds a new empty WorkExperience with updated position" do
    work_experience = nil
    cv = Cv.new

    assert_difference("cv.work_experiences.size", 1) { work_experience = cv.add_work_experience }

    assert work_experience.title.blank?
    assert work_experience.entity.blank?
    assert work_experience.entity_uri.blank?
    assert work_experience.period.blank?
    assert work_experience.description.blank?
    assert work_experience.tags.blank?
    assert_equal 1, work_experience.position

    assert_difference("cv.work_experiences.size", 1) { work_experience = cv.add_work_experience }
    assert_equal 2, work_experience.position
  end

  test "#delete_work_experience marks a WorkExperience for destruction when the Cv is saved" do
    cv = cvs(:two)
    first_id = cv.work_experiences.first.id
    second_position = cv.work_experiences.second.position

    assert_difference("cv.work_experiences.count", -1) do
      cv.delete_work_experience(first_id)
      cv.save
    end
  end
end
