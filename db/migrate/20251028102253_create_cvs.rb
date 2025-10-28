class CreateCvs < ActiveRecord::Migration[8.0]
  def change
    create_table :cvs do |t|
      t.string :name, null: false
      t.string :email_address, null: false

      t.string :intro_line
      t.string :intro_text

      t.string :base_filename, default: "cv.en"
      t.string :language, default: "en"

      t.timestamps
    end
  end
end
