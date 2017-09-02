class AddUser < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :checksum
      t.timestamps
    end
  end
end
