require "test_helper"

class CvTest < ActiveSupport::TestCase
  test "Can have all attributes empty" do
    cv = Cv.new

    assert cv.valid?
  end

  test "#create_layout builds an empty Layout record for the CV" do
    cv = Cv.new
    cv.create_layout

    assert cv.layout.present?
    assert cv.layout.page_breaks.blank?
    assert cv.layout.cv_id.nil?
  end

  test '#add_contact adds (but not saves) a new empty Contact with updated position and type "generic"' do
    contact = nil
    cv = Cv.new

    assert_difference("cv.contacts.count", 1) do
      contact = cv.add_contact
      cv.save
    end
    assert contact.value.blank?
    assert_equal "generic", contact.contact_type
    assert_equal 1, contact.position

    assert_difference("cv.contacts.count", 1) do
      contact = cv.add_contact
      cv.save
    end
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

  test "#add_education_item adds (but not saves) a new empty EducationItem with updated position" do
    education_item = nil
    cv = Cv.new

    assert_difference("cv.education_items.count", 1) do
      education_item = cv.add_education_item
      cv.save
    end
    assert education_item.name.blank?
    assert education_item.location.blank?
    assert education_item.date.blank?
    assert_equal 1, education_item.position

    assert_difference("cv.education_items.count", 1) do
      education_item = cv.add_education_item
      cv.save
    end
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

  test "#add_language adds (but not saves) a new empty Language with updated position" do
    language = nil
    cv = Cv.new

    assert_difference("cv.languages.count", 1) do
      language = cv.add_language
      cv.save
    end


    assert language.name.blank?
    assert language.level.blank?
    assert_equal 1, language.position

    assert_difference("cv.languages.count", 1) do
      language = cv.add_language
      cv.save
    end
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

  test "#add_work_experience adds (but not saves) a new empty WorkExperience with updated position" do
    work_experience = nil
    cv = Cv.new

    assert_difference("cv.work_experiences.count", 1) do
      work_experience = cv.add_work_experience
      cv.save
    end


    assert work_experience.title.blank?
    assert work_experience.entity.blank?
    assert work_experience.entity_uri.blank?
    assert work_experience.period.blank?
    assert work_experience.description.blank?
    assert work_experience.tags.blank?
    assert_equal 1, work_experience.position

    assert_difference("cv.work_experiences.count", 1) do
      work_experience = cv.add_work_experience
      cv.save
    end
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
