class Modrequest < ApplicationRecord

    belongs_to :course
    has_one :user
    
end
