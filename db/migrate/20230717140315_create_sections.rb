class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections do |t|
      t.references :teacher, foreign_key: true, null: false
      t.references :subject, foreign_key: true, null: false
      t.references :classroom, foreign_key: true, null: false
      t.datetime :starting_at, null: false
      t.integer :duration, null: false

      t.timestamps
    end
    add_index :sections, [:teacher_id, :subject_id, :classroom_id]
  end
end
