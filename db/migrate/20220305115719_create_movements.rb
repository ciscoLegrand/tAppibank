class CreateMovements < ActiveRecord::Migration[7.0]
  def change
    create_table :movements do |t|
      t.references :account, null: false, foreign_key: true
      t.string :type_movement
      t.decimal :amount, precision: 10, scale: 2
      t.string :description

      t.timestamps
    end
  end
end
