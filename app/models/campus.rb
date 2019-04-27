class Campus < ApplicationRecord
    has_many :courses, class_name: "courses", foreign_key: "course_id", dependent: :destroy
    has_many :rooms, class_name: "rooms", foreign_key: "room_id", dependent: :destroy

    
end
