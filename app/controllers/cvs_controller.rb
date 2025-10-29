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
      params.expect(cv: [ :name, :email_address, :intro_line, :intro_text, :base_filename, :language, :notes ])
    end
end
