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

  test "should update related records at the same time" do
    @cv = cvs(:two)

    contact_attributes = @cv.contacts.first.attributes
    contact_attributes["contact_type"] = "phone"
    contact_attributes["value"] = "0987654321"

    education_item_attributes = @cv.education_items.first.attributes
    education_item_attributes["name"] = "Washing Machine studies Diploma"
    education_item_attributes["location"] = "Somewhere in the middle of the Ocean"
    education_item_attributes["date"] = "2021"

    cv_attributes = @cv.attributes
    cv_attributes["name"] = "Changed Name"
    cv_attributes["email_address"] = "Changed Email"

    attributes = cv_attributes.dup
    attributes["contacts_attributes"] = [ contact_attributes ]
    attributes["education_items_attributes"] = [ education_item_attributes ]

    patch cv_url(@cv), params: { cv: attributes }

    assert_redirected_to edit_cv_url(@cv)

    assert_attribute_values(@cv.reload, cv_attributes)
    assert_attribute_values(@cv.contacts.first, contact_attributes)
    assert_attribute_values(@cv.education_items.first, education_item_attributes)
  end

  test "should destroy cv" do
    assert_difference("Cv.count", -1) do
      delete cv_url(@cv)
    end

    assert_redirected_to cvs_url
  end
end
