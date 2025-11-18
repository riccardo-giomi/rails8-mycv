require "test_helper"

class CvsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cv = cvs(:one)
  end

  test "should get index" do
    get cvs_url
    assert_response :success
  end

  test "create requests should create an empty CV and redirect to index" do
    assert_difference("Cv.count") { post cvs_url }
    assert_redirected_to cvs_url

    assert Cv.last.name.blank?
    assert Cv.last.email_address.blank?
  end

  test "should show CV" do
    get cv_url(@cv)
    assert_response :success
  end

  test "should allow download of a CV as JSON" do
    get cv_url(@cv, format: :json)

    assert_equal @cv.to_json, response.body
    assert_match /attachment; filename="john-doe.json"/, response.headers["content-disposition"]
  end

  test "should create a copy of a CV" do
    @cv = cvs(:two)

    assert_difference("Cv.count", 1) do
      post copy_cv_url(@cv)
    end

    copy = Cv.last
    assert copy.layout.present?
    assert_equal 2, copy.contacts.size
    assert_equal 2, copy.education_items.size
    assert_equal 2, copy.languages.size
    assert_equal 2, copy.work_experiences.size
  end

  test "should get edit" do
    get edit_cv_url(@cv)
    assert_response :success
  end

  test "should update CV" do
    attributes = {
        base_filename: "curriculum.es",
        email_address: "me@example.org",
        intro_line: " Barrendero profesional",
        intro_text: "Yo Barro, Professionalmente.",
        language: "es",
        name: "El Barrendero",
        notes: "Me gusta mucho barrer!"
      }

    patch cv_url(@cv), params: { cv: attributes }

    assert_attribute_values(@cv.reload, attributes)

    assert_redirected_to edit_cv_url(@cv)
  end

  test "should allow to add empty contacts" do
    assert_difference("@cv.contacts.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_contact: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 1, @cv.contacts.last.position

    assert_difference("@cv.contacts.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_contact: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 2, @cv.contacts.last.position
  end

  test "should allow to remove a contact" do
    @cv = cvs(:two)

    assert_difference("@cv.contacts.count", -1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, delete_contact: @cv.contacts.last.id }
    end

    assert_redirected_to edit_cv_url(@cv)
  end

  test "should allow to add empty education items" do
    assert_difference("@cv.education_items.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_education_item: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 1, @cv.education_items.last.position

    assert_difference("@cv.education_items.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_education_item: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 2, @cv.education_items.last.position
  end

  test "should allow to remove a education item" do
    @cv = cvs(:two)

    assert_difference("@cv.education_items.count", -1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, delete_education_item: @cv.education_items.last.id }
    end

    assert_redirected_to edit_cv_url(@cv)
  end

  test "should allow to add empty languages" do
    assert_difference("@cv.languages.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_language: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 1, @cv.languages.last.position

    assert_difference("@cv.languages.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_language: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 2, @cv.languages.last.position
  end

  test "should allow to remove a language" do
    @cv = cvs(:two)

    assert_difference("@cv.languages.count", -1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, delete_language: @cv.languages.last.id }
    end

    assert_redirected_to edit_cv_url(@cv)
  end

  test "should allow to add empty work experiences" do
    assert_difference("@cv.work_experiences.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_work_experience: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 1, @cv.work_experiences.last.position

    assert_difference("@cv.work_experiences.count", 1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, add_work_experience: 1 }
    end

    assert_redirected_to edit_cv_url(@cv)
    assert_equal 2, @cv.work_experiences.last.position
  end

  test "should allow to change work-experiences positions (up)" do
    @cv = cvs(:two)
    assert_equal "Door Stopper", @cv.work_experiences.first.title
    assert_equal "Flea Back-Scratcher", @cv.work_experiences.second.title

    patch cv_url(@cv), params: { cv: @cv.attributes, move_work_experience_up: @cv.work_experiences.second.id }
    @cv.work_experiences.reload

    assert_equal "Flea Back-Scratcher", @cv.work_experiences.first.title
    assert_equal "Door Stopper", @cv.work_experiences.second.title
  end

  test "should allow to change work-experiences positions (down)" do
    @cv = cvs(:two)
    assert_equal "Door Stopper", @cv.work_experiences.first.title
    assert_equal "Flea Back-Scratcher", @cv.work_experiences.second.title

    patch cv_url(@cv), params: { cv: @cv.attributes, move_work_experience_down: @cv.work_experiences.first.id }
    @cv.work_experiences.reload

    assert_equal "Flea Back-Scratcher", @cv.work_experiences.first.title
    assert_equal "Door Stopper", @cv.work_experiences.second.title
  end

  test "should allow to remove a work_experience" do
    @cv = cvs(:two)

    assert_difference("@cv.work_experiences.count", -1) do
      patch cv_url(@cv), params: { cv: @cv.attributes, delete_work_experience: @cv.work_experiences.last.id }
    end

    assert_redirected_to edit_cv_url(@cv)
  end

  test "should update related records at the same time" do
    @cv = cvs(:two)

    contact_attributes = @cv.contacts.first.attributes
    contact_attributes["contact_type"] = "phone"
    contact_attributes["value"]        = "0987654321"

    education_item_attributes = @cv.education_items.first.attributes
    education_item_attributes["name"]     = "Washing Machine studies Diploma"
    education_item_attributes["location"] = "Somewhere in the middle of the Ocean"
    education_item_attributes["date"]     = "2021"

    language_attributes = @cv.languages.first.attributes
    language_attributes["name"]  = "Japanese"
    language_attributes["level"] = "Incapable"

    work_experience_attributes = @cv.work_experiences.first.attributes
    work_experience_attributes["title"]       = "Changed title"
    work_experience_attributes["entity"]      = "Changed entity"
    work_experience_attributes["entity_uri"]  = "Changed entity URI"
    work_experience_attributes["period"]      = "Changed period"
    work_experience_attributes["description"] = "Changed description"
    work_experience_attributes["tags"]        = "Changed tags"

    cv_attributes = @cv.attributes
    cv_attributes["name"]          = "Changed Name"
    cv_attributes["email_address"] = "Changed Email"

    attributes = cv_attributes.dup
    attributes["contacts_attributes"]         = [ contact_attributes ]
    attributes["education_items_attributes"]  = [ education_item_attributes ]
    attributes["languages_attributes"]        = [ language_attributes ]
    attributes["work_experiences_attributes"] = [ work_experience_attributes ]

    patch cv_url(@cv), params: { cv: attributes }

    assert_redirected_to edit_cv_url(@cv)

    assert_attribute_values(@cv.reload, cv_attributes)
    assert_attribute_values(@cv.contacts.first, contact_attributes)
    assert_attribute_values(@cv.education_items.first, education_item_attributes)
    assert_attribute_values(@cv.languages.first, language_attributes)
    assert_attribute_values(@cv.work_experiences.first, work_experience_attributes)
  end

  test "should destroy cv" do
    assert_difference("Cv.count", -1) do
      delete cv_url(@cv)
    end

    assert_redirected_to cvs_url
  end
end
