require "application_system_test_case"

class ContactsReorderTest < ApplicationSystemTestCase
  setup do
    @cv = cvs(:two)
    @first = contacts(:one)
    @second = contacts(:two)
  end

  test "clicking move down persists the new order and updates which arrows are disabled" do
    visit edit_cv_url(@cv)

    reorder_container_selector = "[data-reorder-url-value='#{reorder_cv_contacts_path(@cv)}']"

    assert_selector "#contact_#{@first.id} #move-contact-up-button:disabled"
    assert_selector "#contact_#{@second.id} #move-contact-up-button:not(:disabled)"
    assert_selector "#contact_#{@second.id} #move-contact-down-button:disabled"

    find("#contact_#{@first.id} #move-contact-down-button").click

    assert_selector "#{reorder_container_selector}[data-reorder-complete], #{reorder_container_selector}[data-reorder-error]"

    container = find(reorder_container_selector)
    if (error = container["data-reorder-error"])
      raise "reorder request failed: #{error}"
    end

    assert_equal [ @second.id, @first.id ], @cv.reload.contacts.pluck(:id)

    assert_selector "#contact_#{@second.id} #move-contact-up-button:disabled"
    assert_selector "#contact_#{@first.id} #move-contact-up-button:not(:disabled)"
    assert_selector "#contact_#{@first.id} #move-contact-down-button:disabled"
  end
end
