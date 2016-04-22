class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :address
      t.text :geolocation
      t.string :type
      t.belongs_to :parent, index: true

      t.timestamps null: false
    end
    add_foreign_key :contacts, :contacts, column: :parent_id
  end
end
