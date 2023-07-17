class Student < ApplicationRecord
  has_many :student_sections, dependent: :destroy
  has_many :sections, through: :student_sections

  validates :first_name, :last_name, presence: true
end
