class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address_line, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :zip_code, null: false

      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
    add_index :addresses, :zip_code
  end
end