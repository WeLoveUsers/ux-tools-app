class ReadAppNotification < ApplicationRecord
  
  belongs_to :user
  belongs_to :app_notification

  validates :app_notification, uniqueness: { scope: :user }

end
