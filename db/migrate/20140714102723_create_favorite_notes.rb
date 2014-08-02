class CreateFavoriteNotes < ActiveRecord::Migration
  def change
    create_table :favorite_notes do |t|
      t.references :user
      t.references :note
    end

    add_index :favorite_notes, [:user_id, :note_id], unique: true
  end
end
