class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name
      t.text :objective
      t.text :information
      t.integer :limit
      t.date :start_date
      t.text :discord_id

      t.timestamps null: false
    end
  end
end
