class Classroom < ApplicationRecord
  belongs_to :campus
  has_many :events, dependent: :destroy
  has_many :classroomcomments, dependent: :destroy

  validates_uniqueness_of :title, scope: [:campus_id]


  acts_as_votable
end
