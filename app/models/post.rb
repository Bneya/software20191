class Post < ApplicationRecord
  belongs_to :course

  belongs_to :user

  has_many :postcomments, dependent: :destroy

  # Relacionado a los votos
  acts_as_votable

  # Para poder filtrar
  include Filterable

  scope :course_id, -> (course_id) { where course_id: course_id }
  # scope :contains, -> {where('title LIKE ?', contains) }
end
