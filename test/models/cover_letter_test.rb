require "test_helper"

class CoverLetterTest < ActiveSupport::TestCase
  test "must have a name" do
    cover_letter = CoverLetter.new
    assert cover_letter.invalid?
    assert cover_letter.errors[:name].any?
  end
end
