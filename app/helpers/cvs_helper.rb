module CvsHelper
  def contact_icon_partial(contact_type)
    return "cvs/contact_icons/generic" unless Contact::TYPES.include?(contact_type.to_sym)

    "cvs/contact_icons/#{contact_type}"
  end
end
