class Course < ApplicationRecord
  resourcify 
  
  has_many :posts, dependent: :destroy

  has_many :modrequests, class_name: "modrequest", foreign_key: "reference_id"
  
  belongs_to :campus

  # probando línea
  has_and_belongs_to_many :users
end
