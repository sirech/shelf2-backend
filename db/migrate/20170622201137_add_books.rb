class AddBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.text :description
      t.integer :year, null: false
      t.integer :stars, default: 1
      t.integer :category, default: 0
      t.timestamps null: false
    end
  end
end
