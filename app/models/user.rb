class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable  and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects, dependent: :destroy
  has_many :read_app_notifications, dependent: :destroy

  def recent_app_notifications
   return AppNotification.where("date > :account_created_at ", {account_created_at: created_at}).order(date: :desc).last(7)
  end

  # Returns the amount (count)
  # of unread notification messages for the current user within the last 7 notifications
  def unread_notifications_count
   last_notifications = AppNotification.where("date > :account_created_at ", {account_created_at: created_at}).order(:date).select("id").last(7).pluck(:id)
   read_notifications = read_app_notifications.select("app_notification_id").pluck(:app_notification_id)
   return (last_notifications - read_notifications).size
  end

  # Returns true | false
  # depending on if the current user has read the notification
  def has_read_notification(app_notification)
   return ReadAppNotification.exists?(app_notification_id: app_notification.id, user_id: id)
  end

end
