class CreateCvs < ActiveRecord::Migration[8.0]
  def change
    create_table :cvs do |t|
      t.string :name
      t.string :email_address
      t.string :notes

      t.string :intro_line
      t.text   :intro_text

      t.string :base_filename
      t.string :language

      t.timestamps
    end
  end
end
