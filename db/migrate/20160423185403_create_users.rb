class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :name, null: false
      t.text :email, null: false
      t.text :image_url
      t.date :start_date
      t.text :discord_id

      t.timestamps null: false
    end
  end
end
