require "test_helper"

class CvTest < ActiveSupport::TestCase
  test "Requires some attributes" do
    cv = Cv.new

    assert cv.invalid?
  end
end
