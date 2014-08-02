class CreateNoteTypes < ActiveRecord::Migration
  def change
    create_table :note_types do |t|
      t.string :name, :length => 20
      t.string :description, :length => 255
      t.timestamps
    end
  end
end
