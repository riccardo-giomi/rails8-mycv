module CvsHelper
  def contact_icon_partial(contact_type)
    return "cvs/contact_icons/generic" unless Contact::TYPES.include?(contact_type.to_sym)

    "cvs/contact_icons/#{contact_type}"
  end

  def page_break?(cv, name, position: nil)
    name += "_#{position}" if position
    cv.layout.page_breaks.include?(name)
  end

  def page_break_checkbox(cv, name, position: nil, class: "")
    checked =  page_break?(cv, name, position:)

    name += "_#{position}" if position
    field_name = "cv[layout_attributes][page_breaks][#{name}]"

    hidden_field = hidden_field_tag field_name, ""
    checkbox = checkbox_tag(field_name, 1, checked, class:)

    hidden_field + checkbox
  end

  def page_break(cv, name, position: nil)
    return unless page_break?(cv, name, position:)

    separator = tag.hr class: "mb-1 mt-2 border-t-2 border-dashed border-gray-400 print:hidden"
    break_tag = tag.div class: "break-before-page"
    separator + break_tag
  end
end
