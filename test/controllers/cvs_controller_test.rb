require "test_helper"

class CvsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cv = cvs(:one)
  end

  test "should get index" do
    get cvs_url
    assert_response :success
  end

  test "should get new" do
    get new_cv_url
    assert_response :success
  end

  test "should create cv" do
    assert_difference("Cv.count") do
      post cvs_url, params: {
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
    end

    assert_redirected_to cv_url(Cv.last)
  end

  test "should show cv" do
    get cv_url(@cv)
    assert_response :success
  end

  test "should get edit" do
    get edit_cv_url(@cv)
    assert_response :success
  end

  test "should update cv" do
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
    assert_redirected_to cv_url(@cv)
  end

  test "should destroy cv" do
    assert_difference("Cv.count", -1) do
      delete cv_url(@cv)
    end

    assert_redirected_to cvs_url
  end
end
