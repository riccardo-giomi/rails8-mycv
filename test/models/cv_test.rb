require "test_helper"

class CvTest < ActiveSupport::TestCase
  test "Can have all attributes empty" do
    cv = Cv.new

    assert cv.valid?
  end
end
