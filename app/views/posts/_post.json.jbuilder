json.extract! post, :id, :user_id, :course_id, :content, :title, :rate, :created_at, :updated_at
json.url post_url(post, format: :json)
