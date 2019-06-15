class Classroomcomment < ApplicationRecord
  belongs_to :classroom
  belongs_to :user

  # Relacionado a los comentarios
  acts_as_votable

end
