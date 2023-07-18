class Student < ApplicationRecord
  has_many :student_sections, dependent: :destroy
  has_many :sections, through: :student_sections

  validates :first_name, :last_name, presence: true

  def first_and_last_name
    "#{first_name} #{last_name}"
  end
end
