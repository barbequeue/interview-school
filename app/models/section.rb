class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  has_many :student_sections, dependent: :destroy
  has_many :students, through: :teacher_subjects
end
