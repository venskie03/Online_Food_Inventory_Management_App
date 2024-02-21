class CreateIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.string :ingredients_name
      t.integer :quantity
      t.string :unit
      t.references :meal, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
