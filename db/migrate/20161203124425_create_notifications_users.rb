class CreateNotificationsUsers < ActiveRecord::Migration
  def change
    create_table :notifications_users do |t|
      t.references :notification, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :read

      t.timestamps null: false
    end
  end
end
