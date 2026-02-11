class CoverLettersController < ApplicationController
  before_action :set_cover_letter, only: %i[ show edit update destroy ]

  def index
    @cover_letters = CoverLetter.all
    @added = params[:added]&.to_i || nil
  end

  def show
  end

  def new
    @cover_letter = CoverLetter.new
  end

  def edit
  end

  def create
    @cover_letter = CoverLetter.new(cover_letter_params)

    respond_to do |format|
      if @cover_letter.save
        format.html { redirect_to cover_letters_path(added: @cover_letter.id), notice: "Cover letter was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cover_letter.update(cover_letter_params)
        format.html { redirect_to edit_cover_letter_path(@cover_letter), notice: "Cover letter was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cover_letter.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to cover_letters_path, notice: "Cover letter was successfully destroyed.", status: :see_other }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cover_letter
      @cover_letter = CoverLetter.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def cover_letter_params
      params.expect(cover_letter: [ :name, :company_name, :company_url, :job_url, :content, :active ])
    end
end
