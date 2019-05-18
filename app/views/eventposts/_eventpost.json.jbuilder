json.extract! eventpost, :id, :title, :user_id, :event_id, :content, :rate, :created_at, :updated_at
json.url eventpost_url(eventpost, format: :json)
