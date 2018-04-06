class CreatePurchases < ActiveRecord::Migration[5.1]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :price_in_cents
      t.string :charge_id

      t.timestamps
    end
  end
end
