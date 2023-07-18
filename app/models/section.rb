class Section < ApplicationRecord
  DURATIONS = [50, 80].freeze

  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom

  has_many :student_sections, dependent: :destroy
  has_many :students, through: :teacher_subjects

  validates :starting_at, :duration, presence: true

  validate do |section|
    SectionValidator.validate(section)
  end

  default_scope { select("sections.*") }
  scope :with_teachers, -> do
    select("teachers.first_name as teacher_first_name, teachers.last_name as teacher_last_name")
    .joins(:teacher)
  end
  scope :with_subjects, -> do
    select("subjects.name as subject_name, subjects.description as subject_description")
    .joins(:subject)
  end
  scope :with_classrooms, -> do
    select("classrooms.number as classroom_number")
    .joins(:classroom)
  end
  scope :with_student_counts, -> do
    select("IFNULL(students_per_section.count, 0) as section_students_count")
    .joins("left join (
              select section_id,
                     count(student_id) as count
              from student_sections
              group by section_id
            ) as students_per_section on students_per_section.section_id = sections.id")
  end
end

class SectionValidator
  def self.validate(section)
    new(section).validate
  end

  def initialize(section)
    @section = section
  end

  def validate
    # TODO: Move to Query object
    # TODO: Add advanced validation (e.g. teacher is busy at the time)
    if section.teacher.present? && section.subject.present?
      unless TeacherSubject.exists?(teacher: section.teacher, subject: section.subject)
        section.errors.add(:teacher, :invalid, message: "doesn't teach the subject")
      end
    end
  end

  private

  attr_reader :section
end
