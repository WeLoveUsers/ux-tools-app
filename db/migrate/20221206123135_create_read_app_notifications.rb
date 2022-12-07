class CreateReadAppNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :read_app_notifications do |t|
      t.references :user, foreign_key: true
      t.references :app_notification, foreign_key: true

      t.timestamps
    end

    add_index :read_app_notifications, [:user_id, :app_notification_id], unique: true
  end
end
