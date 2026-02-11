require "application_system_test_case"

class CoverLettersTest < ApplicationSystemTestCase
  setup do
    @cl_full = cover_letters(:one)
    @cl_minimal = cover_letters(:two)
  end

  test "visiting the index" do
    visit cover_letters_url

    assert_selector "h1", text: "Cover Letters"

    assert_link "New Cover Letter"

    # turbo-frame
    within("#cover_letter_#{@cl_full.id}") do
      assert_selector "p", text: @cl_full.name
      assert_selector "p" do
        assert_link @cl_full.company_name, href: @cl_full.company_url
      end
    end

    # turbo-frame
    within("#cover_letter_#{@cl_minimal.id}") do
      assert_selector "p", text: @cl_minimal.name
      assert_selector "p", text: @cl_minimal.company_name
    end
  end

  test "creating a new cover letter" do
    visit cover_letters_url
    click_on "New Cover Letter"

    assert_selector "h1", text: "New Cover Letter"
  end
end
