require "application_system_test_case"

class EducationItemsReorderTest < ApplicationSystemTestCase
  setup do
    @cv = cvs(:two)
    @first = education_items(:one)
    @second = education_items(:two)
    @reorder_container_selector = "[data-reorder-url-value='#{reorder_cv_education_items_path(@cv)}']"
  end

  test "clicking move down persists the new order and updates which arrows are disabled" do
    visit edit_cv_url(@cv)

    assert_selector "#education_item_#{@first.id} #move-education-item-up-button:disabled"
    assert_selector "#education_item_#{@second.id} #move-education-item-up-button:not(:disabled)"
    assert_selector "#education_item_#{@second.id} #move-education-item-down-button:disabled"

    find("#education_item_#{@first.id} #move-education-item-down-button").click

    assert_selector "#{@reorder_container_selector}[data-reorder-complete], #{@reorder_container_selector}[data-reorder-error]"

    container = find(@reorder_container_selector)
    if (error = container["data-reorder-error"])
      raise "reorder request failed: #{error}"
    end

    assert_equal [ @second.id, @first.id ], @cv.reload.education_items.pluck(:id)

    assert_selector "#education_item_#{@second.id} #move-education-item-up-button:disabled"
    assert_selector "#education_item_#{@first.id} #move-education-item-up-button:not(:disabled)"
    assert_selector "#education_item_#{@first.id} #move-education-item-down-button:disabled"
  end
end
