class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.text :content
      t.integer :user_id
      t.integer :lick_id

      t.timestamps
    end
  end
end
