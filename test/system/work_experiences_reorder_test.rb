require "application_system_test_case"

class WorkExperiencesReorderTest < ApplicationSystemTestCase
  setup do
    @cv = cvs(:two)
    @first = work_experiences(:one)
    @second = work_experiences(:two)
  end

  test "dragging a work experience above another persists the new order" do
    visit edit_cv_url(@cv)

    handle = find("#work_experience_#{@second.id} [data-action*='dragstart']")
    target = find("#work_experience_#{@first.id}")

    page.execute_script(<<~JS, handle, target)
      const [ handle, target ] = arguments
      const dataTransfer = new DataTransfer()
      const rect = target.getBoundingClientRect()

      handle.dispatchEvent(new DragEvent("dragstart", { bubbles: true, dataTransfer }))
      target.dispatchEvent(new DragEvent("dragover", { bubbles: true, cancelable: true, dataTransfer, clientY: rect.top }))
      target.dispatchEvent(new DragEvent("drop", { bubbles: true, dataTransfer }))
    JS

    assert_selector "[data-controller='reorder'][data-reorder-complete], [data-controller='reorder'][data-reorder-error]"

    container = find("[data-controller='reorder']")
    if (error = container["data-reorder-error"])
      raise "reorder request failed: #{error}"
    end

    assert_equal [ @second.id, @first.id ], @cv.reload.work_experiences.pluck(:id)
  end

  test "dragging a work experience below another persists the new order" do
    visit edit_cv_url(@cv)

    handle = find("#work_experience_#{@first.id} [data-action*='dragstart']")
    target = find("#work_experience_#{@second.id}")

    page.execute_script(<<~JS, handle, target)
    const [ handle, target ] = arguments
    const dataTransfer = new DataTransfer()
    const rect = target.getBoundingClientRect()

    handle.dispatchEvent(new DragEvent("dragstart", { bubbles: true, dataTransfer }))
    target.dispatchEvent(new DragEvent("dragover", { bubbles: true, cancelable: true, dataTransfer, clientY: rect.bottom }))
    target.dispatchEvent(new DragEvent("drop", { bubbles: true, dataTransfer }))
    JS

    assert_selector "[data-controller='reorder'][data-reorder-complete], [data-controller='reorder'][data-reorder-error]"

    container = find("[data-controller='reorder']")
    if (error = container["data-reorder-error"])
      raise "reorder request failed: #{error}"
    end

    assert_equal [ @second.id, @first.id ], @cv.reload.work_experiences.pluck(:id)
  end
end
