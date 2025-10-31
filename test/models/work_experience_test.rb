require "test_helper"

class WorkExperienceTest < ActiveSupport::TestCase
  test "#has_tags?" do
    without_tags = WorkExperience.new
    with_tags = WorkExperience.new(tags: "tag1, tag2")
    with_annoying_tags = WorkExperience.new(tags: "    ")

    refute without_tags.has_tags?
    refute with_annoying_tags.has_tags?
    assert with_tags.has_tags?
  end

  test "#tags_array returns an array from the comma separated strings in #tags" do
    no_tags = WorkExperience.new
    no_real_tags = WorkExperience.new(tags: "    ")
    with_tags = WorkExperience.new(tags: " tag1 ,tag2, tag3 ")

    assert_equal [], no_tags.tags_array
    assert_equal [], no_real_tags.tags_array

    assert_equal %w[tag1 tag2 tag3], with_tags.tags_array
  end
end
