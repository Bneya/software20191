class Eventpost < ApplicationRecord
  belongs_to :event

  belongs_to :user

  has_many :eventpostcomments, dependent: :destroy

  # Relacionado a los votos
  acts_as_votable

  scope :event_id, -> (event_id) { where event_id: event_id }

end
