class CreateLayouts < ActiveRecord::Migration[8.0]
  def change
    create_table :layouts do |t|
      t.text :page_breaks, default: "[]"
      t.references :cv, null: false, foreign_key: true, index: { unique: true }

      t.timestamps
    end
  end
end
