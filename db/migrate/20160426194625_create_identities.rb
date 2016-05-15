class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.text :uid, null: false
      t.text :provider, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
