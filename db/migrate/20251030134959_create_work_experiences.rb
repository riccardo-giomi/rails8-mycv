class CreateWorkExperiences < ActiveRecord::Migration[8.0]
  def change
    create_table :work_experiences do |t|
      t.string :title
      t.string :entity
      t.string :entity_uri
      t.string :period
      t.text :description
      t.string :tags

      t.references :cv, null: false, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
