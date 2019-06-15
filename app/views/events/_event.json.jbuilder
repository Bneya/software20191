json.extract! event, :id, :title, :description, :classroom_id, :course_id, :schedule, :day, :event_type, :user_id, :max_users, :price, :created_at, :updated_at
json.url event_url(event, format: :json)
