class CreateEducationItems < ActiveRecord::Migration[8.0]
  def change
    create_table :education_items do |t|
      t.string :name # e.g. Bachelor's Degree in ...
      t.string :location # e.g. University of Mars
      t.string :date # Date-like string, for human readers

      t.references :cv, null: false, foreign_key: true
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
