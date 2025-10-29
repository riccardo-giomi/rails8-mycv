class CreateContacts < ActiveRecord::Migration[8.0]
  def change
    create_table :contacts do |t|
      t.string     :contact_type, null: false, default: "generic"
      t.string     :value

      t.references :cv, null: false, foreign_key: true
      t.integer    :position, default: 1

      t.timestamps
    end
  end
end
