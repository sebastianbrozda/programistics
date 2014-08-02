class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :note, :null => false
      t.integer :status, :null => false
      t.boolean :settled, :default => false
      t.string :custom, :null => false, :limit => 40
      t.decimal :price, :precision => 12, :scale => 8, :nil => false, :default => 0
      t.string :coinbase_order_id
      t.string :transaction_hash
      t.decimal :transaction_fee, :precision => 12, :scale => 8, :null => true
      t.timestamps
    end

    add_index :payments, :custom, unique: true
    add_index :payments, :note_id
    add_index :payments, :user_id
    add_index :payments, :coinbase_order_id, unique: true
    add_index :payments, :transaction_hash, unique: true
  end
end
