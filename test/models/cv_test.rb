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

  test "#as_json includes data from the associations" do
    cv = cvs(:two)
    json = cv.as_json

    assert_equal cv.layout.as_json, json[:layout]
    assert_equal cv.contacts.first.as_json, json[:contacts].first
    assert_equal cv.contacts.second.as_json, json[:contacts].second
    assert_equal cv.education_items.first.as_json, json[:education_items].first
    assert_equal cv.education_items.second.as_json, json[:education_items].second
    assert_equal cv.languages.first.as_json, json[:languages].first
    assert_equal cv.languages.second.as_json, json[:languages].second
    assert_equal cv.work_experiences.first.as_json, json[:work_experiences].first
    assert_equal cv.work_experiences.second.as_json, json[:work_experiences].second
  end

  test "#build_copy creates a deep copy of the CV with no ids and not persisted" do
    cv = cvs(:two)
    copy = cv.build_copy

    assert copy.id.nil?

    assert_equal "Jane D'oh!",                       copy.name
    assert_equal "j-d@example.org",                  copy.email_address
    assert_equal "intro-line, ma in Italiano!",      copy.intro_line
    assert_equal "intro-text, ma in Italiano!",      copy.intro_text
    assert_equal "cv.it",                            copy.base_filename
    assert_equal "it",                               copy.language
    assert_equal "CV in Italiano",                   copy.notes
    assert_equal "Educazione",                       copy.education_label
    assert_equal "Lingue",                           copy.languages_label
    assert_equal "Carriera",                         copy.intro_text_label
    assert_equal "Esperienza",                       copy.work_experience_label
    assert_equal "(Continua nella prossima pagina)", copy.work_experience_continues_label
    assert_equal "Esperienza (continua)",            copy.work_experience_continued_label


    assert copy.layout.id.nil?
    assert_equal [], copy.layout.page_breaks


    contact_copy = copy.contacts.first
    assert contact_copy.id.nil?
    assert_equal "linkedin", contact_copy.contact_type
    assert_equal "linkedin.example.org", contact_copy.value
    assert_equal 1, contact_copy.position

    contact_copy = copy.contacts.second
    assert contact_copy.id.nil?
    assert_equal "github", contact_copy.contact_type
    assert_equal "github.example.org", contact_copy.value
    assert_equal 2, contact_copy.position

    education_item_copy = copy.education_items.first
    assert education_item_copy.id.nil?
    assert_equal "Diploma", education_item_copy.name
    assert_equal "Springfield High School", education_item_copy.location
    assert_equal "2007", education_item_copy.date
    assert_equal 1, education_item_copy.position

    education_item_copy = copy.education_items.second
    assert education_item_copy.id.nil?
    assert_equal "Batchelor's Degree", education_item_copy.name
    assert_equal "Random University", education_item_copy.location
    assert_equal "1999", education_item_copy.date
    assert_equal 2, education_item_copy.position

    language_copy = copy.languages.first
    assert language_copy.id.nil?
    assert_equal "Italian", language_copy.name
    assert_equal "native", language_copy.level
    assert_equal 1, language_copy.position

    language_copy = copy.languages.second
    assert language_copy.id.nil?
    assert_equal "English", language_copy.name
    assert_equal "professional", language_copy.level
    assert_equal 2, language_copy.position

    experience_item_copy = copy.work_experiences.first
    assert_equal "Door Stopper", experience_item_copy.title
    assert_equal "Second door on the left", experience_item_copy.entity
    assert_equal "door-2-left.example.org", experience_item_copy.entity_uri
    assert_equal "2000-2024", experience_item_copy.period
    assert_equal "I kept that door stopped, cometh rain or storm.", experience_item_copy.description
    assert_equal "door,stopper", experience_item_copy.tags
    assert_equal 1, experience_item_copy.position

    experience_item_copy = copy.work_experiences.second
    assert_equal "Flea Back-Scratcher", experience_item_copy.title
    assert_equal "EU Parasites United Union", experience_item_copy.entity
    assert_equal "eu-puu.example.org", experience_item_copy.entity_uri
    assert_equal "1970 - Today", experience_item_copy.period
    assert_equal "They are not going to scratch themselves!", experience_item_copy.description
    assert_equal "scratcher, flea-friend, #noBaths", experience_item_copy.tags
    assert_equal 2, experience_item_copy.position
  end
end
