json.extract! event, :id, :title, :description, :classroom_id, :course_id, :schedule, :day, :event_type, :actual_users, :max_users, :price, :created_at, :updated_at
json.url event_url(event, format: :json)
