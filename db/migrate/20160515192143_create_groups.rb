class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :name, null: false
      t.text :objective, null: false
      t.text :information, null: false
      t.integer :limit, null: false
      t.date :start_date, null: false
      t.text :discord_id

      t.timestamps null: false
    end
  end
end
