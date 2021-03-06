class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :currency, foreign_key: true
      t.integer :txn_type
      t.decimal :units
      t.decimal :amount_unit
      t.decimal :txn_amt

      t.timestamps
    end
  end
end
