class AddNotesToCvs < ActiveRecord::Migration[8.0]
  def change
    add_column :cvs, :notes, :string
  end
end
