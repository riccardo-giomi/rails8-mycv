class AddLabelFieldsToCvs < ActiveRecord::Migration[8.0]
  def change
    add_column :cvs, :education_label, :string, default: "Education"
    add_column :cvs, :languages_label, :string, default: "Languages"
    add_column :cvs, :intro_text_label, :string, default: "Career Summary"
    add_column :cvs, :work_experience_label, :string, default: "Work Experience"
    add_column :cvs, :work_experience_continues_label, :string, default: "(Continued in the next page)"
    add_column :cvs, :work_experience_continued_label, :string, default: "Work Experience (continued)"
  end
end
