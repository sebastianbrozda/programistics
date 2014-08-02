class CreatePurchasedNotes < ActiveRecord::Migration
  def change
    create_table :purchased_notes do |t|
      t.belongs_to :user
      t.belongs_to :note
      t.timestamps
    end

    add_index :purchased_notes, [:user_id, :note_id], unique: true
  end
end
