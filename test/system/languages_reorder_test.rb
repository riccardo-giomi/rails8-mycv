require "application_system_test_case"

class LanguagesReorderTest < ApplicationSystemTestCase
  setup do
    @cv = cvs(:two)
    @first = languages(:one)
    @second = languages(:two)
    @reorder_container_selector = "[data-reorder-url-value='#{reorder_cv_languages_path(@cv)}']"
  end

  test "clicking move down persists the new order and updates arrow visibility" do
    visit edit_cv_url(@cv)

    assert_no_selector "#language_#{@first.id} #move-language-up-button", visible: :visible
    assert_selector "#language_#{@second.id} #move-language-up-button", visible: :visible
    assert_no_selector "#language_#{@second.id} #move-language-down-button", visible: :visible

    find("#language_#{@first.id} #move-language-down-button").click

    assert_selector "#{@reorder_container_selector}[data-reorder-complete], #{@reorder_container_selector}[data-reorder-error]"

    container = find(@reorder_container_selector)
    if (error = container["data-reorder-error"])
      raise "reorder request failed: #{error}"
    end

    assert_equal [ @second.id, @first.id ], @cv.reload.languages.pluck(:id)

    assert_no_selector "#language_#{@second.id} #move-language-up-button", visible: :visible
    assert_selector "#language_#{@first.id} #move-language-up-button", visible: :visible
    assert_no_selector "#language_#{@first.id} #move-language-down-button", visible: :visible
  end
end
