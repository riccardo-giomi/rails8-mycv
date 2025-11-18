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

  test "#move_work_experience_up switches an experience position with the previous one" do
    cv = cvs(:two)
    first_experience = cv.work_experiences.first
    second_experience = cv.work_experiences.second

    cv.move_work_experience_up(first_experience)
    assert first_experience.position = 1
    assert second_experience.position = 2

    cv.move_work_experience_up(second_experience)
    assert first_experience.position = 2
    assert second_experience.position = 1
  end

  test "#move_work_experience_down switches an experience position with the previous one" do
    cv = cvs(:two)
    first_experience = cv.work_experiences.first
    second_experience = cv.work_experiences.second

    cv.move_work_experience_down(second_experience)
    assert first_experience.position = 1
    assert second_experience.position = 2

    cv.move_work_experience_down(first_experience)
    assert first_experience.position = 2
    assert second_experience.position = 1
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

  test "Cv::from_json creates a new (unsaved) Cv with associations from a JSON string" do
    cv = cvs(:two)
    json_string = cv.build_copy.to_json

    new_cv = Cv.from_json(json_string)
    assert_copy_of_cv2(new_cv)
  end

  test "#build_copy creates a deep copy of the CV with no ids and not persisted" do
    cv = cvs(:two)
    assert_copy_of_cv2(cv.build_copy)
  end


  def assert_copy_of_cv2(cv)
    assert cv.id.nil?

    assert_equal "Jane D'oh!",                       cv.name
    assert_equal "j-d@example.org",                  cv.email_address
    assert_equal "intro-line, ma in Italiano!",      cv.intro_line
    assert_equal "intro-text, ma in Italiano!",      cv.intro_text
    assert_equal "cv.it",                            cv.base_filename
    assert_equal "it",                               cv.language
    assert_equal "CV in Italiano",                   cv.notes
    assert_equal "Educazione",                       cv.education_label
    assert_equal "Lingue",                           cv.languages_label
    assert_equal "Carriera",                         cv.intro_text_label
    assert_equal "Esperienza",                       cv.work_experience_label
    assert_equal "(Continua nella prossima pagina)", cv.work_experience_continues_label
    assert_equal "Esperienza (continua)",            cv.work_experience_continued_label


    assert cv.layout.id.nil?
    assert_equal [], cv.layout.page_breaks


    contact = cv.contacts.first
    assert contact.id.nil?
    assert_equal "linkedin", contact.contact_type
    assert_equal "linkedin.example.org", contact.value
    assert_equal 1, contact.position

    contact = cv.contacts.second
    assert contact.id.nil?
    assert_equal "github", contact.contact_type
    assert_equal "github.example.org", contact.value
    assert_equal 2, contact.position

    education_item = cv.education_items.first
    assert education_item.id.nil?
    assert_equal "Diploma", education_item.name
    assert_equal "Springfield High School", education_item.location
    assert_equal "2007", education_item.date
    assert_equal 1, education_item.position

    education_item = cv.education_items.second
    assert education_item.id.nil?
    assert_equal "Batchelor's Degree", education_item.name
    assert_equal "Random University", education_item.location
    assert_equal "1999", education_item.date
    assert_equal 2, education_item.position

    language = cv.languages.first
    assert language.id.nil?
    assert_equal "Italian", language.name
    assert_equal "native", language.level
    assert_equal 1, language.position

    language = cv.languages.second
    assert language.id.nil?
    assert_equal "English", language.name
    assert_equal "professional", language.level
    assert_equal 2, language.position

    experience_item = cv.work_experiences.first
    assert_equal "Door Stopper", experience_item.title
    assert_equal "Second door on the left", experience_item.entity
    assert_equal "door-2-left.example.org", experience_item.entity_uri
    assert_equal "2000-2024", experience_item.period
    assert_equal "I kept that door stopped, cometh rain or storm.", experience_item.description
    assert_equal "door,stopper", experience_item.tags
    assert_equal 1, experience_item.position

    experience_item = cv.work_experiences.second
    assert_equal "Flea Back-Scratcher", experience_item.title
    assert_equal "EU Parasites United Union", experience_item.entity
    assert_equal "eu-puu.example.org", experience_item.entity_uri
    assert_equal "1970 - Today", experience_item.period
    assert_equal "They are not going to scratch themselves!", experience_item.description
    assert_equal "scratcher, flea-friend, #noBaths", experience_item.tags
    assert_equal 2, experience_item.position
  end
end
