require "test_helper"

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cv = cvs(:two)
    @first = languages(:one)
    @second = languages(:two)
  end

  test "reorder updates positions to match the given order" do
    patch reorder_cv_languages_url(@cv), params: { ids: [ @second.id, @first.id ] }

    assert_response :success
    assert_equal 1, @second.reload.position
    assert_equal 2, @first.reload.position
  end

  test "reorder is reflected in the cv's default languages ordering" do
    patch reorder_cv_languages_url(@cv), params: { ids: [ @second.id, @first.id ] }

    assert_equal [ @second, @first ], @cv.reload.languages.to_a
  end

  test "raises RecordNotFound for invalid positions" do
    patch reorder_cv_languages_url(@cv), params: { ids: [ @first.id, 999_999 ] }

    assert_response :not_found
  end
end
