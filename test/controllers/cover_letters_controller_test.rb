require "test_helper"

class CoverLettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cover_letter = cover_letters(:one)
  end

  test "should get index" do
    get cover_letters_url
    assert_response :success
  end

  test "should get new" do
    get new_cover_letter_url
    assert_response :success
  end

  test "should create a cover letter" do
    assert_difference("CoverLetter.count") do
      post cover_letters_url, params: { cover_letter: { name: @cover_letter.name, active: @cover_letter.active, company_name: @cover_letter.company_name, company_url: @cover_letter.company_url, content: @cover_letter.content, job_url: @cover_letter.job_url } }
    end

    # There's an extra parameter that will probably disappear, this should
    # ignore the parameter in the expected redirect URL
    assert_redirected_to %r{#{cover_letters_url}}
  end

  test "should not create an invalid cover letter" do
    assert_no_difference("CoverLetter.count") do
      post cover_letters_url, params: { cover_letter: { name: "", active: @cover_letter.active, company_name: @cover_letter.company_name, company_url: @cover_letter.company_url, content: @cover_letter.content, job_url: @cover_letter.job_url } }
    end

    assert_in_body "New Cover Letter"
  end

  test "should show a cover letter" do
    get cover_letter_url(@cover_letter)
    assert_response :success
  end

  test "should get edit" do
    get edit_cover_letter_url(@cover_letter)
    assert_response :success
  end

  test "should save a cover letter and stay on its edit page" do
    patch cover_letter_url(@cover_letter), params: { cover_letter: { active: @cover_letter.active, company_name: @cover_letter.company_name, company_url: @cover_letter.company_url, content: @cover_letter.content, job_url: @cover_letter.job_url, name: @cover_letter.name } }
    assert_redirected_to edit_cover_letter_url(@cover_letter)
  end

  test "should destroy a cover letter" do
    assert_difference("CoverLetter.count", -1) do
      delete cover_letter_url(@cover_letter)
    end

    assert_redirected_to cover_letters_url
  end
end
