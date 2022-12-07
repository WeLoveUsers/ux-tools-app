class CreateAppNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :app_notifications do |t|
      t.datetime :date
      t.string :notification_type
      t.string :title
      t.text :content
      
      t.timestamps
    end
  end
end
