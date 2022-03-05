class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      # t.references :users
      t.string :type_account
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
