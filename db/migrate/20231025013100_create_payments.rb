class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :name
      t.decimal :amount
      t.integer :author_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_reference :payments, :category, foreign_key: true
  end
end
