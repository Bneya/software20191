json.extract! modrequest, :id, :user_id, :course_id, :created_at, :updated_at
json.url modrequest_url(modrequest, format: :json)
