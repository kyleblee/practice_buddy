class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :uid
      t.string :image
      t.text :description
      t.boolean :admin
      t.integer :location_id

      t.timestamps
    end
  end
end
