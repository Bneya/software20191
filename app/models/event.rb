class Event < ApplicationRecord
  has_many :eventposts, dependent: :destroy

  belongs_to :classroom

  # probando línea
  has_and_belongs_to_many :users
end
