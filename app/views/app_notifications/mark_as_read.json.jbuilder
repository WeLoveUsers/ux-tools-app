json.extract! @read_app_notification, :app_notification_id, :user_id
json.url mark_notification_as_read_url(@read_app_notification.app_notification, format: :json)
