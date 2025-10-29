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
    patch cv_url(@cv), params: {
      cv: {
        base_filename: "curriculum.es",
        email_address: "me@example.org",
        intro_line: " Barrendero profesional",
        intro_text: "Yo Barro, Professionalmente.",
        language: "es",
        name: "El Barrendero",
        notes: "Me gusta mucho barrer!"
      }
    }
    assert_redirected_to edit_cv_url(@cv)
  end

  test "should destroy cv" do
    assert_difference("Cv.count", -1) do
      delete cv_url(@cv)
    end

    assert_redirected_to cvs_url
  end
end
