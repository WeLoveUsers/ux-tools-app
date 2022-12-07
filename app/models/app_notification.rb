class AppNotification < ApplicationRecord

  has_many :read_app_notifications, dependent: :destroy

  validates_presence_of :date, :notification_type, :title, :content

  def read_count
    read_app_notifications.count
  end

  def should_have_read_count
    User.where("created_at <= :notification_date", {notification_date: date}).count
  end
  
end
