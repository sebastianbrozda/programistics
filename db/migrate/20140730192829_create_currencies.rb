class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.decimal :price, :precision => 12, :scale => 8
      t.timestamps
    end
  end
end
