class Eventpostcomment < ApplicationRecord
  belongs_to :eventpost
  belongs_to :user

  # Relacionado a los comentarios
  acts_as_votable

end
