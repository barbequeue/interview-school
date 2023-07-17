class Classroom < ApplicationRecord
  has_many :sections, dependent: :destroy

  validates :number, presence: true
end
