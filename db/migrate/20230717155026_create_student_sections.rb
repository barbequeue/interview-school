class CreateStudentSections < ActiveRecord::Migration[6.0]
  def change
    create_table :student_sections do |t|
      t.references :student, foreign_key: true, null: false
      t.references :section, foreign_key: true, null: false

      t.timestamps
    end
    add_index :student_sections, [:student_id, :section_id]
  end
end
