class Postcomment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # Relacionado a los comentarios
  acts_as_votable

end
