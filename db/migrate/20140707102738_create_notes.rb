class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title, :length => 255
      t.text :body
      t.text :short_body
      t.references :user, index: true
      t.references :note_type, index: true
      t.integer :comment_count, default: 0
      t.decimal :price_for_access, :decimal, :precision => 8, :scale => 2, :nil => false, :default => 0
      t.timestamps
    end
  end
end
