class CreateCoverLetters < ActiveRecord::Migration[8.1]
  def change
    create_table :cover_letters do |t|
      t.string :name
      t.string :company_name
      t.string :company_url
      t.string :job_url
      t.text :content
      t.boolean :active

      t.timestamps
    end
  end
end
