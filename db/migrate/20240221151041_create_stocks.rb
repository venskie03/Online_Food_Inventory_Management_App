class CreateStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :stocks do |t|
      t.string :ingredients_name
      t.integer :quantity
      t.string :unit
      t.references :user, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
