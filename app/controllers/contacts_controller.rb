class ContactsController < ApplicationController
  def reorder
    cv = Cv.find(params[:cv_id])
    ids = params.expect(ids: [])

    ids.each_with_index do |id, index|
      cv.contacts.find(id).update!(position: index + 1)
    end

    head :ok
  end
end
