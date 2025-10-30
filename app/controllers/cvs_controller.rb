class CvsController < ApplicationController
  before_action :set_cv, only: %i[ show edit update destroy ]

  def index
    @cvs = Cv.all
  end

  def show
  end

  def create
    @cv = Cv.create
    respond_to do |format|
      format.html { redirect_to cvs_path, notice: "CV was successfully created.", status: :see_other }
    end
  end

  def edit
  end

  def update
    @cv.delete_contact(params[:delete_contact]) if params[:delete_contact]
    @cv.add_contact if params[:add_contact]

    @cv.delete_education_item(params[:delete_education_item]) if params[:delete_education_item]
    @cv.add_education_item if params[:add_education_item]

    @cv.delete_language(params[:delete_language]) if params[:delete_language]
    @cv.add_language if params[:add_language]

    respond_to do |format|
      if @cv.update(cv_params)
        format.html { redirect_to edit_cv_path(@cv), notice: "CV saved.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cv.destroy!

    respond_to do |format|
      format.html { redirect_to cvs_path, notice: "CV was successfully destroyed.", status: :see_other }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cv
    @cv = Cv.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def cv_params
    params.expect(
      cv: [
        :name,
        :email_address,
        :intro_line,
        :intro_text,
        :base_filename,
        :language,
        :notes,
        contacts_attributes: [ %i[id contact_type value] ],
        education_items_attributes: [ %i[id name location date] ],
        languages_attributes: [ %i[id name level] ]
      ]
    )
  end
end
