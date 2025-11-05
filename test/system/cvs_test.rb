require "application_system_test_case"

class CvsTest < ApplicationSystemTestCase
  setup do
    @cv = cvs(:one)
  end

  test "visiting the index" do
    visit cvs_url
    assert_selector "h1", text: "CVs"
    assert_selector "p", text: @cv.name
    assert_selector "p", text: @cv.intro_line
    assert_selector "span", text: @cv.email_address
    assert_selector "span", text: "#{@cv.base_filename}.*"
    assert_selector "span", text: @cv.language
    assert_selector "p", text: @cv.notes
    assert_selector "span", text: @cv.updated_at.to_fs(:short)
  end

  test "should create an empty CV" do
    visit cvs_url
    click_on "New CV"

    assert_text "CV was successfully created"

    assert_selector "p", text: "No Name given"
    assert_selector "span", text: "No Email Address given"
  end

  test "should update CV" do
    visit cvs_url
    click_on "Edit this CV", match: :first

    fill_in "cv_base_filename", with: @cv.base_filename
    fill_in "Email address", with: @cv.email_address
    fill_in "cv_intro_line", with: @cv.intro_line
    fill_in "cv_intro_text", with: @cv.intro_text
    fill_in "CV Language", with: @cv.language
    fill_in "Name", with: @cv.name
    fill_in "Notes", with: @cv.notes

    click_on "Save", match: :first

    assert_text "CV saved."
    click_on "Back"
  end

  test "should destroy CV" do
    visit cvs_url
    accept_confirm { click_on "Delete this CV", match: :first }

    assert_text "CV was successfully destroyed"
  end
end
