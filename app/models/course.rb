class Course < ApplicationRecord
  has_many :posts, dependent: :destroy

  belongs_to :campus

  # probando línea
  has_and_belongs_to_many :users
end
