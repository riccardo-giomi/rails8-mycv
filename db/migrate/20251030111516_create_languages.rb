class CreateLanguages < ActiveRecord::Migration[8.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :level

      t.references :cv, null: false, foreign_key: true
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
