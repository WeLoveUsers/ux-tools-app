json.extract! app_notification, :id, :date, :notification_type, :title, :content, :created_at, :updated_at
json.url app_notification_url(app_notification, format: :json)
