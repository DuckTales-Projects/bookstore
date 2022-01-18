# frozen_string_literal:true

class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.string :genre
      t.string :language
      t.string :edition
      t.string :place
      t.integer :year

      t.timestamps
    end
  end
end
