require "test_helper"

class LayoutTest < ActiveSupport::TestCase
  test "#page_breaks is a custom type attribute that is a text in the db and an array outside" do
    layout = Layout.new(page_breaks: [ "after_intro_text", "after_work_experience_0", "after_work_experience_1" ])
    attribute = layout.type_for_attribute(:page_breaks)

    assert layout.page_breaks.is_a? Array

    assert_equal :page_breaks, attribute.type
    assert_equal '["after_intro_text","after_work_experience_0","after_work_experience_1"]', attribute.serialize(layout.page_breaks)
  end

  test "There can be only one layout per CV" do
    cv = cvs(:one)

    layout = Layout.new(cv: cv)

    assert layout.invalid?
    assert_match /taken/, layout.errors[:cv_id].first
  end
end
