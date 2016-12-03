class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :sender, index: true
      t.references :notifiable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
