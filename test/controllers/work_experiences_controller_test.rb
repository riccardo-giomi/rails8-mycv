require "test_helper"

class WorkExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cv = cvs(:two)
    @first = work_experiences(:one)
    @second = work_experiences(:two)
  end

  test "reorder updates positions to match the given order" do
    patch reorder_cv_work_experiences_url(@cv), params: { ids: [ @second.id, @first.id ] }

    assert_response :success
    assert_equal 1, @second.reload.position
    assert_equal 2, @first.reload.position
  end

  test "reorder is reflected in the cv's default work_experiences ordering" do
    patch reorder_cv_work_experiences_url(@cv), params: { ids: [ @second.id, @first.id ] }

    assert_equal [ @second, @first ], @cv.reload.work_experiences.to_a
  end

  test "raises RecordNotFound for invalid positions" do
    patch reorder_cv_work_experiences_url(@cv), params: { ids: [ @first.id, 999_999 ] }

    assert_response :not_found
  end
end
